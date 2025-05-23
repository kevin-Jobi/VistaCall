// import 'package:flutter/material.dart';

// // Dummy Conversation Model (since we don't have a backend yet)
// class Conversation {
//   final String doctorName;
//   final String lastMessage;
//   final String timestamp;
//   final bool isUnread;

//   Conversation({
//     required this.doctorName,
//     required this.lastMessage,
//     required this.timestamp,
//     required this.isUnread,
//   });
// }

// class MessagesScreen extends StatelessWidget {
//    MessagesScreen({super.key});

//   // Dummy data for conversations
//   final List<Conversation> conversations = [
//     Conversation(
//       doctorName: 'Dr. John Smith',
//       lastMessage: 'How are you feeling?',
//       timestamp: '10:30 AM',
//       isUnread: true,
//     ),
//      Conversation(
//       doctorName: 'Dr. Emily Johnson',
//       lastMessage: 'Your test results are ready.',
//       timestamp: 'Yesterday',
//       isUnread: false,
//     ),
//      Conversation(
//       doctorName: 'Dr. Sarah Davis',
//       lastMessage: 'Please schedule a follow-up.',
//       timestamp: 'May 15',
//       isUnread: true,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF4A90E2), // Blue
//         title: const Text('Messages'),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: conversations.isEmpty
//           ? const Center(child: Text('No messages yet'))
//           : ListView.separated(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               itemCount: conversations.length,
//               itemBuilder: (context, index) {
//                 final conversation = conversations[index];
//                 return ListTile(
//                   leading: const CircleAvatar(
//                     backgroundColor: Colors.grey,
//                     child: Icon(Icons.person, color: Colors.white),
//                   ),
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         conversation.doctorName,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         conversation.timestamp,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   subtitle: Row(
//                     children: [
//                       if (conversation.isUnread)
//                         Container(
//                           margin: const EdgeInsets.only(right: 8),
//                           width: 8,
//                           height: 8,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFF4A90E2),
//                           ),
//                         ),
//                       Expanded(
//                         child: Text(
//                           conversation.lastMessage,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: conversation.isUnread
//                                 ? Colors.black
//                                 : Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     // TODO: Navigate to chat screen for this conversation
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Chat with ${conversation.doctorName} coming soon!')),
//                     );
//                   },
//                 );
//               },
//               separatorBuilder: (context, index) => const Divider(
//                 height: 1,
//                 thickness: 1,
//                 color: Colors.grey,
//               ),
//             ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: 2, // Messages tab selected
//           selectedItemColor: const Color(0xFF4A90E2), // Blue
//           unselectedItemColor: Colors.grey.shade500,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           type: BottomNavigationBarType.fixed,
//           selectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 12,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.w400,
//             fontSize: 12,
//           ),
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               activeIcon: Icon(Icons.home, size: 28),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today),
//               activeIcon: Icon(Icons.calendar_today, size: 28),
//               label: 'Appointment',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.chat),
//               activeIcon: Icon(Icons.chat, size: 28),
//               label: 'Messages',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               activeIcon: Icon(Icons.person, size: 28),
//               label: 'Profile',
//             ),
//           ],
//           onTap: (index) {
//             if (index == 0) {
//               Navigator.pushReplacementNamed(context, '/home');
//             } else if (index == 1) {
//               Navigator.pushReplacementNamed(context, '/appointments');
//             } else if (index == 3) {
//               Navigator.pushReplacementNamed(context, '/profile');
//             }
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/data/models/conversation.dart';
import 'package:vistacall/viewmodels/messages_bloc.dart';
import 'package:vistacall/utils/constants.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messagesBloc = BlocProvider.of<MessagesBloc>(context);
    messagesBloc.add(LoadMessagesEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: const Text('Messages'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: BlocBuilder<MessagesBloc, MessagesState>(
        builder: (context, state) {
          if (state is MessagesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessagesErrorState) {
            return Center(child: Text(state.error));
          } else if (state is MessagesLoadedState) {
            final conversations = state.conversations;
            return conversations.isEmpty
                ? const Center(child: Text('No messages yet'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = conversations[index];
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              conversation.doctorName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              conversation.timestamp,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            if (conversation.isUnread)
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppConstants.primaryColor,
                                ),
                              ),
                            Expanded(
                              child: Text(
                                conversation.lastMessage,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: conversation.isUnread ? Colors.black : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Chat with ${conversation.doctorName} coming soon!')),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppConstants.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 2,
          selectedItemColor: AppConstants.primaryColor,
          unselectedItemColor: Colors.grey.shade500,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              activeIcon: Icon(Icons.calendar_today, size: 28),
              label: 'Appointment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              activeIcon: Icon(Icons.chat, size: 28),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
            } else if (index == 3) {
              Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
            }
          },
        ),
      ),
    );
  }
}