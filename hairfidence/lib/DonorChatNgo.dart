import 'package:flutter/material.dart';

class ChatWithNgoPage extends StatefulWidget {
  const ChatWithNgoPage({super.key});

  @override
  State<ChatWithNgoPage> createState() => _ChatWithNgoPageState();
}

class _ChatWithNgoPageState extends State<ChatWithNgoPage> {
  final TextEditingController messageController = TextEditingController();

  // Dummy chat messages
  final List<Map<String, dynamic>> messages = [
    {
      "text": "Hello, your hair donation request has been approved.",
      "isSender": false,
    },
    {
      "text": "Thank you! Please let me know the next steps.",
      "isSender": true,
    },
    {
      "text": "You can visit our center on the approved date.",
      "isSender": false,
    },
  ];

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": messageController.text.trim(),
        "isSender": true,
      });
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Chat with NGO",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: Column(
        children: [
          /// Chat Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isSender = message["isSender"];

                return Align(
                  alignment:
                      isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isSender
                          ? const Color(0xFFFFC107)
                          : const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message["text"],
                      style: TextStyle(
                        color: isSender ? Colors.black : Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Message Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF1C1C1C),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFFFC107)),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
