import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/ip_setup.dart';
import 'PatientChatPage.dart';
import 'login.dart'; // for proid & baseUrl

class PatientChatListPage extends StatefulWidget {
  const PatientChatListPage({super.key});

  @override
  State<PatientChatListPage> createState() => _PatientChatListPageState();
}

class _PatientChatListPageState extends State<PatientChatListPage> {
  final Dio dio = Dio();

  bool loading = true;
  List chats = [];

  @override
  void initState() {
    super.initState();
    loadChats();
  }

  /// ================= LOAD CHAT LIST =================
  Future<void> loadChats() async {
    try {
      final res = await dio.post(
        "$baseUrl/chat/my",
        data: {
          "profileId": proid,
          "profileRole": "patient",
        },
      );

      setState(() {
        chats = res.data;
        loading = false;
      });
    } catch (e) {
      loading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load chats")),
      );
    }
  }

  /// ================= OPEN CHAT =================
  void openChat(chat) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PatientChatPage(
          conversationId: chat["conversationId"],
          ngoName: chat["name"],
        ),
      ),
    );
    loadChats();
  }

  /// ================= LOAD NGOs =================
  Future<void> showNgoModal() async {
    try {
      final res = await dio.get("$baseUrl/ngos");
      final ngos = res.data;

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black,
        builder: (_) => ListView(
          children: ngos.map<Widget>((ngo) {
            return ListTile(
              title: Text(
                ngo["name"],
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                ngo["district"] ?? "",
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () async {
                Navigator.pop(context);

                final convo = await dio.post(
                  "$baseUrl/chat/create-or-get",
                  data: {
                    "profileId": proid,
                    "profileRole": "patient",
                    "otherProfileId": ngo["_id"],
                    "otherProfileRole": "ngo",
                  },
                );
                print(convo);

                openChat({
                  "conversationId": convo.data["conversationId"],
                  "name": ngo["name"],
                });
              },
            );
          }).toList(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load NGOs")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Chats",
          style: TextStyle(color: Color(0xFFFFC107)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFFFFC107)),
            onPressed: showNgoModal,
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : chats.isEmpty
              ? const Center(
                  child: Text(
                    "No conversations yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (_, i) {
                    final chat = chats[i];

                    return ListTile(
                      title: Text(
                        chat["name"],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        chat["lastMessage"] ?? "No messages",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: chat["unreadCount"] > 0
                          ? CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: Text(
                                chat["unreadCount"].toString(),
                                style:
                                    const TextStyle(color: Colors.white),
                              ),
                            )
                          : null,
                      onTap: () => openChat(chat),
                    );
                  },
                ),
    );
  }
}
