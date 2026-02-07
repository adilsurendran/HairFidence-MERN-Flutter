import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/ip_setup.dart';
import 'login.dart'; // baseUrl & proid

class PatientChatPage extends StatefulWidget {
  final String conversationId;
  final String ngoName;

  const PatientChatPage({
    super.key,
    required this.conversationId,
    required this.ngoName,
  });

  @override
  State<PatientChatPage> createState() => _PatientChatPageState();
}

class _PatientChatPageState extends State<PatientChatPage> {
  final Dio dio = Dio();
  final TextEditingController controller = TextEditingController();

  List messages = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMessages();
    markAsRead();
  }

  /// ================= LOAD MESSAGES =================
  Future<void> loadMessages() async {
    final res = await dio.get(
      "$baseUrl/chat/messages/${widget.conversationId}",
    );

    setState(() {
      messages = res.data;
      loading = false;
    });
  }

  /// ================= MARK READ =================
  Future<void> markAsRead() async {
    await dio.post(
      "$baseUrl/chat/mark-read",
      data: {
        "conversationId": widget.conversationId,
        "profileId": proid,
      },
    );
  }

  /// ================= SEND MESSAGE =================
  Future<void> sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    await dio.post(
      "$baseUrl/chat/send",
      data: {
        "conversationId": widget.conversationId,
        "senderId": proid,
        "senderRole": "patient",
        "message": controller.text,
      },
    );

    controller.clear();
    loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Color(0xFFFFC107)),
        title: Text(
          widget.ngoName,
          style: const TextStyle(color: Color(0xFFFFC107)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (_, i) {
                      final msg = messages[i];
                      final isMe =
                          msg["senderRole"] == "patient";

                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                              const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe
                                ? const Color(0xFFFFC107)
                                : Colors.grey.shade800,
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg["message"],
                            style: TextStyle(
                              color:
                                  isMe ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style:
                        const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      hintStyle:
                          TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Color(0xFFFFC107)),
                  onPressed: sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
