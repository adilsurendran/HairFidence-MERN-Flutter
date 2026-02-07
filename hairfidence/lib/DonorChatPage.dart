import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/ip_setup.dart';
import 'login.dart'; // baseUrl & proid
import 'DonorHomePage.dart'; // for ngoId

class DonorChatPage extends StatefulWidget {
  const DonorChatPage({super.key});

  @override
  State<DonorChatPage> createState() => _DonorChatPageState();
}

class _DonorChatPageState extends State<DonorChatPage> {
  final Dio dio = Dio();
  final TextEditingController controller = TextEditingController();

  String? conversationId;
  String ngoName = "NGO";

  bool loading = true;
  List messages = [];

  @override
  void initState() {
    super.initState();
    initChat();
  }

  /// ================= INIT CHAT =================
  Future<void> initChat() async {
    try {
      // 1️⃣ Create or get conversation
      final convoRes = await dio.post(
        "$baseUrl/chat/create-or-get",
        data: {
          "profileId": proid,
          "profileRole": "donor",
          "otherProfileId": ngoId,
          "otherProfileRole": "ngo",
        },
      );

      conversationId = convoRes.data["conversationId"];

      // 2️⃣ Load messages
      await loadMessages();

      // 3️⃣ Mark as read
      await dio.post(
        "$baseUrl/chat/mark-read",
        data: {
          "conversationId": conversationId,
          "profileId": proid,
        },
      );

      setState(() => loading = false);
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to open chat")),
      );
    }
  }

  /// ================= LOAD MESSAGES =================
  Future<void> loadMessages() async {
    final res = await dio.get(
      "$baseUrl/chat/messages/$conversationId",
    );
    setState(() => messages = res.data);
  }

  /// ================= SEND MESSAGE =================
  Future<void> sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    await dio.post(
      "$baseUrl/chat/send",
      data: {
        "conversationId": conversationId,
        "senderId": proid,
        "senderRole": "donor",
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
        title: Text(
          ngoName,
          style: const TextStyle(color: Color(0xFFFFC107)),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (_, i) {
                      final msg = messages[i];
                      final isMe = msg["senderRole"] == "donor";

                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe
                                ? const Color(0xFFFFC107)
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(12),
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
