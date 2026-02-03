import 'package:flutter/material.dart';

class PatientNgoChatPage extends StatefulWidget {
  const PatientNgoChatPage({super.key});

  @override
  State<PatientNgoChatPage> createState() => _PatientNgoChatPageState();
}

class _PatientNgoChatPageState extends State<PatientNgoChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  /// Dummy patient-NGO chat messages
  final List<Map<String, dynamic>> chatMessages = [
    {
      "text": "Hello! Your request has been approved.",
      "isPatient": false,
    },
    {
      "text": "Thank you! When should I visit the center?",
      "isPatient": true,
    },
    {
      "text": "You can come this Saturday between 10 AM and 2 PM.",
      "isPatient": false,
    },
  ];

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      chatMessages.add({
        "text": messageController.text.trim(),
        "isPatient": true,
      });
    });

    messageController.clear();

    /// Scroll to bottom after sending
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC107),
        title: const Text(
          "Patient - NGO Chat",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          /// CHAT MESSAGES
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(14),
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final msg = chatMessages[index];
                final isPatient = msg["isPatient"];

                return Align(
                  alignment:
                      isPatient ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                        maxWidth:
                            MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isPatient
                          ? const Color(0xFFFFC107)
                          : const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft:
                            isPatient ? const Radius.circular(16) : Radius.zero,
                        bottomRight:
                            isPatient ? Radius.zero : const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isPatient ? "Patient" : "NGO",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isPatient ? Colors.black87 : Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg["text"],
                          style: TextStyle(
                            color: isPatient ? Colors.black : Colors.white,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// MESSAGE INPUT BAR
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1C),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xFFFFC107),
                        width: 1,
                      ),
                    ),
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
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFFFFC107),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
