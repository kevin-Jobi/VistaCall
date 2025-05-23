// import 'package:flutter/material.dart';

// // Dummy Message Model
// class Message {
//   final String text;
//   final bool isUser; // True if sent by user, false if sent by AI
//   final String timestamp;

//   Message({
//     required this.text,
//     required this.isUser,
//     required this.timestamp,
//   });
// }

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Message> _messages = [
//     Message(
//       text: "Hello! How can I assist you today?",
//       isUser: false,
//       timestamp: "09:21 AM",
//     ),
//   ];

//   void _sendMessage(String text) {
//     if (text.trim().isEmpty) return;

//     // Add user's message
//     setState(() {
//       _messages.add(Message(
//         text: text,
//         isUser: true,
//         timestamp: "09:22 AM", // Simulated timestamp
//       ));

//       // Simulate AI response
//       _messages.add(Message(
//         text: _getDummyAIResponse(text),
//         isUser: false,
//         timestamp: "09:23 AM", // Simulated timestamp
//       ));
//     });

//     _controller.clear();
//   }

//   String _getDummyAIResponse(String userMessage) {
//     // Simulate AI responses based on user input
//     if (userMessage.toLowerCase().contains("headache")) {
//       return "I'm sorry to hear about your headache. Have you tried drinking water or taking a rest? If it persists, you might want to consult a doctor.";
//     } else if (userMessage.toLowerCase().contains("appointment")) {
//       return "You can book an appointment through the Appointments tab. Would you like to know more about a specific doctor?";
//     } else {
//       return "I'm here to help! Can you tell me more about your concern?";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF4A90E2), // Blue
//         title: const Text('Ask Care AI'),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return Align(
//                   alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: message.isUser ? const Color(0xFF4A90E2) : Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           message.text,
//                           style: TextStyle(
//                             color: message.isUser ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           message.timestamp,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: message.isUser ? Colors.white70 : Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type your message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   backgroundColor: const Color(0xFF4A90E2),
//                   child: IconButton(
//                     icon: const Icon(Icons.send, color: Colors.white),
//                     onPressed: () {
//                       _sendMessage(_controller.text);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/data/models/message.dart';
import 'package:vistacall/viewmodels/chat_bloc.dart';
import 'package:vistacall/utils/constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final TextEditingController _controller = TextEditingController();
    chatBloc.add(LoadChatEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: const Text('Ask Care AI'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatErrorState) {
            return Center(child: Text(state.error));
          } else if (state is ChatLoadedState) {
            final messages = state.messages;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: message.isUser ? AppConstants.primaryColor : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.text,
                                style: TextStyle(
                                  color: message.isUser ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message.timestamp,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: message.isUser ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: AppConstants.primaryColor,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            final text = _controller.text.trim();
                            if (text.isNotEmpty) {
                              chatBloc.add(SendMessageEvent(text));
                              _controller.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}