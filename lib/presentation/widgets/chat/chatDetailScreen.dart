// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/chat/chat_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_event.dart';
// import 'package:vistacall/utils/constants.dart';

// class ChatDetailScreen extends StatefulWidget {
//   final String doctorId;
//   final String doctorName;
//   final String chatId;

//   const ChatDetailScreen({
//     super.key,
//     required this.doctorId,
//     required this.doctorName,
//     required this.chatId,
//   });

//   @override
//   State<ChatDetailScreen> createState() => _ChatDetailScreenState();
// }

// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FocusNode _textFieldFocus = FocusNode();
//   DateTime? _lastDisplayedDate;

//   @override
//   void initState() {
//     super.initState();
//     final chatBloc = BlocProvider.of<ChatBloc>(context);
//     final messagesBloc = BlocProvider.of<MessagesBloc>(context, listen: false);
//     final patientId = _auth.currentUser?.uid ?? 'unknown';

//     // Load chat messages
//     chatBloc.add(LoadChatMessages(widget.doctorId, widget.chatId));

//     // Mark unread messages as read when the chat is opened
//     _markMessagesAsRead(messagesBloc);
//   }

//   Future<void> _markMessagesAsRead(MessagesBloc messagesBloc) async {
//     final patientId = _auth.currentUser?.uid;
//     if (patientId == null) return;

//     try {
//       final querySnapshot = await _db
//           .collection('chats')
//           .doc(widget.chatId)
//           .collection('messages')
//           .where('receiverId', isEqualTo: patientId)
//           .where('isRead', isEqualTo: false)
//           .get();

//       print(
//           'Query for unread messages returned ${querySnapshot.docs.length} documents');
//       if (querySnapshot.docs.isNotEmpty) {
//         final batch = _db.batch();
//         for (var doc in querySnapshot.docs) {
//           print('Updating message ${doc.id} with isRead: true');
//           batch.update(doc.reference, {'isRead': true});
//         }
//         await batch.commit();
//         print(
//             'Marked ${querySnapshot.docs.length} messages as read for chat ${widget.chatId}');
//       } else {
//         print('No unread messages found for chat ${widget.chatId}');
//       }

//       // Reset unreadCount to 0
//       await _db.collection('chats').doc(widget.chatId).update({
//         'unreadCount': 0,
//       });
//       print('Reset unreadCount to 0 for chat ${widget.chatId}');

//       // Refresh the MessagesBloc to update the conversation list
//       messagesBloc.add(LoadMessagesEvent());
//     } catch (e) {
//       print('Error marking messages as read: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     _textFieldFocus.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final patientId = _auth.currentUser?.uid ?? 'unknown';
//     print('Building ChatDetailScreen - PatientID: $patientId');

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       appBar: _buildAppBar(context),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildMessagesStream(patientId, widget.chatId),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Row(
//         children: [
//           _buildDoctorAvatar(),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.doctorName,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDoctorAvatar() {
//     final initials = _getInitials(widget.doctorName);
//     return Container(
//       height: 40,
//       width: 40,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Center(
//         child: Text(
//           initials,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }

//   String _getInitials(String name) {
//     final nameParts = name.trim().split(' ');
//     if (nameParts.length >= 2) {
//       return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
//     } else if (nameParts.isNotEmpty) {
//       return nameParts[0][0].toUpperCase();
//     }
//     return '';
//   }

//   Widget _buildMessagesStream(String patientId, String chatId) {
//     print('Streaming from ChatID: $chatId');
//     return StreamBuilder<QuerySnapshot>(
//       stream: _db
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .orderBy('timestamp', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           print(
//               'No snapshot data - Connection state: ${snapshot.connectionState}, Error: ${snapshot.error}');
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           print('Snapshot error: ${snapshot.error}');
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }

//         final messages = snapshot.data!.docs.map((doc) {
//           final data = doc.data() as Map<String, dynamic>;
//           final timestamp = data['timestamp'] as Timestamp?;
//           final senderId = data['senderId'] as String? ?? 'Unknown';
//           final isPatient = senderId == patientId;
//           final senderName = isPatient ? 'You' : widget.doctorName;
//           final time = timestamp?.toDate().toLocal().toIso8601String() ??
//               DateTime.now().toIso8601String();
//           final isRead = data['isRead'] ?? false;
//           print(
//               'Message data: senderId: $senderId, message: ${data['message']}, time: $time, isRead: $isRead');
//           return MessageModel(
//             senderName: senderName,
//             time: time,
//             message: data['message'] ?? 'No message',
//           );
//         }).toList();

//         print('Total messages fetched: ${messages.length}');
//         if (messages.isEmpty) {
//           print('No messages found in ChatID: $chatId');
//           return const Center(
//             child: Text('No messages yet'),
//           );
//         }

//         return ListView.builder(
//           controller: _scrollController,
//           reverse: true,
//           padding: const EdgeInsets.all(16),
//           itemCount: messages.length,
//           itemBuilder: (context, index) {
//             final message = messages[index];
//             final showTimestamp = _shouldShowTimestamp(messages, index);
//             return _buildMessageBubble(message, showTimestamp);
//           },
//         );
//       },
//     );
//   }

//   bool _shouldShowTimestamp(List<MessageModel> messages, int index) {
//     if (index == 0) return true;
//     final currentDate = DateTime.parse(messages[index].time);
//     final prevDate = DateTime.parse(messages[index - 1].time);
//     return !currentDate.isAtSameMomentAs(prevDate);
//   }

//   Widget _buildMessageBubble(MessageModel message, bool showTimestamp) {
//     final isFromPatient = message.senderName == 'You';
//     return Column(
//       crossAxisAlignment:
//           isFromPatient ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//       children: [
//         if (showTimestamp) _buildTimestampDivider(message.time),
//         Container(
//           margin: EdgeInsets.only(
//             bottom: 8,
//             left: isFromPatient ? 60 : 0,
//             right: isFromPatient ? 0 : 60,
//           ),
//           child: Column(
//             crossAxisAlignment: isFromPatient
//                 ? CrossAxisAlignment.end
//                 : CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isFromPatient
//                       ? AppConstants.primaryColor
//                       : Colors.grey[200],
//                   borderRadius: BorderRadius.only(
//                     topLeft: const Radius.circular(12),
//                     topRight: const Radius.circular(12),
//                     bottomLeft: Radius.circular(isFromPatient ? 12 : 4),
//                     bottomRight: Radius.circular(isFromPatient ? 4 : 12),
//                   ),
//                 ),
//                 child: Text(
//                   message.message,
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: isFromPatient ? Colors.white : Colors.black87,
//                   ),
//                 ),
//               ),
//               Text(
//                 _formatMessageTime(message.time),
//                 style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTimestampDivider(String time) {
//     final date = DateTime.parse(time);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Text(
//         '${date.day}/${date.month}/${date.year}',
//         style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//       ),
//     );
//   }

//   String _formatMessageTime(String time) {
//     final date = DateTime.parse(time);
//     return '${date.hour}:${date.minute}'.padLeft(5, '0');
//   }

//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       color: Colors.white,
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               focusNode: _textFieldFocus,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Colors.blue),
//             onPressed: () {
//               if (_messageController.text.isNotEmpty) {
//                 final chatBloc = BlocProvider.of<ChatBloc>(context);
//                 chatBloc.add(SendMessage(
//                     widget.doctorId, _messageController.text, widget.chatId));
//                 _messageController.clear();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MessageModel {
//   final String senderName;
//   final String time;
//   final String message;

//   MessageModel({
//     required this.senderName,
//     required this.time,
//     required this.message,
//   });
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/chat/chat_bloc.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/utils/constants.dart';

class ChatDetailScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _textFieldFocus = FocusNode();
  DateTime? _lastDisplayedDate;
  bool _isTyping = false;
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final messagesBloc = BlocProvider.of<MessagesBloc>(context, listen: false);
    final patientId = _auth.currentUser?.uid ?? 'unknown';

    chatBloc.add(LoadChatMessages(widget.doctorId, widget.chatId));
    _markMessagesAsRead(messagesBloc);
    
    _messageController.addListener(() {
      setState(() {
        _isTyping = _messageController.text.isNotEmpty;
      });
      if (_isTyping) {
        _fabController.forward();
      } else {
        _fabController.reverse();
      }
    });
  }

  Future<void> _markMessagesAsRead(MessagesBloc messagesBloc) async {
    final patientId = _auth.currentUser?.uid;
    if (patientId == null) return;

    try {
      final querySnapshot = await _db
          .collection('chats')
          .doc(widget.chatId)
          .collection('messages')
          .where('receiverId', isEqualTo: patientId)
          .where('isRead', isEqualTo: false)
          .get();

      print('Query for unread messages returned ${querySnapshot.docs.length} documents');
      if (querySnapshot.docs.isNotEmpty) {
        final batch = _db.batch();
        for (var doc in querySnapshot.docs) {
          print('Updating message ${doc.id} with isRead: true');
          batch.update(doc.reference, {'isRead': true});
        }
        await batch.commit();
        print('Marked ${querySnapshot.docs.length} messages as read for chat ${widget.chatId}');
      } else {
        print('No unread messages found for chat ${widget.chatId}');
      }

      await _db.collection('chats').doc(widget.chatId).update({
        'unreadCount': 0,
      });
      print('Reset unreadCount to 0 for chat ${widget.chatId}');

      messagesBloc.add(LoadMessagesEvent());
    } catch (e) {
      print('Error marking messages as read: $e');
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _textFieldFocus.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientId = _auth.currentUser?.uid ?? 'unknown';
    print('Building ChatDetailScreen - PatientID: $patientId');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesStream(patientId, widget.chatId),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.1),
      surfaceTintColor: Colors.white,
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black87,
              size: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Row(
        children: [
          Hero(
            tag: 'avatar_${widget.doctorName}',
            child: _buildDoctorAvatar(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctorName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.videocam_rounded,
              color: Colors.black87,
              size: 22,
            ),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.phone_rounded,
              color: Colors.black87,
              size: 20,
            ),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDoctorAvatar() {
    final initials = _getInitials(widget.doctorName);
    return Stack(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor,
                AppConstants.primaryColor.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  String _getInitials(String name) {
    final nameParts = name.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return '';
  }

  Widget _buildMessagesStream(String patientId, String chatId) {
    print('Streaming from ChatID: $chatId');
    return StreamBuilder<QuerySnapshot>(
      stream: _db
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print('No snapshot data - Connection state: ${snapshot.connectionState}, Error: ${snapshot.error}');
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final messages = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final timestamp = data['timestamp'] as Timestamp?;
          final senderId = data['senderId'] as String? ?? 'Unknown';
          final isPatient = senderId == patientId;
          final senderName = isPatient ? 'You' : widget.doctorName;
          final time = timestamp?.toDate().toLocal().toIso8601String() ??
              DateTime.now().toIso8601String();
          final isRead = data['isRead'] ?? false;
          print('Message data: senderId: $senderId, message: ${data['message']}, time: $time, isRead: $isRead');
          return MessageModel(
            senderName: senderName,
            time: time,
            message: data['message'] ?? 'No message',
          );
        }).toList();

        print('Total messages fetched: ${messages.length}');
        if (messages.isEmpty) {
          print('No messages found in ChatID: $chatId');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 56,
                    color: AppConstants.primaryColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'No messages yet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start the conversation',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final showTimestamp = _shouldShowTimestamp(messages, index);
            return _buildMessageBubble(message, showTimestamp, index);
          },
        );
      },
    );
  }

  bool _shouldShowTimestamp(List<MessageModel> messages, int index) {
    if (index == messages.length - 1) return true;
    final currentDate = DateTime.parse(messages[index].time);
    final nextDate = DateTime.parse(messages[index + 1].time);
    return currentDate.day != nextDate.day ||
        currentDate.month != nextDate.month ||
        currentDate.year != nextDate.year;
  }

  Widget _buildMessageBubble(MessageModel message, bool showTimestamp, int index) {
    final isFromPatient = message.senderName == 'You';
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment:
            isFromPatient ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (showTimestamp) _buildTimestampDivider(message.time),
          Container(
            margin: EdgeInsets.only(
              bottom: 12,
              left: isFromPatient ? 60 : 0,
              right: isFromPatient ? 0 : 60,
            ),
            child: Column(
              crossAxisAlignment: isFromPatient
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isFromPatient
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppConstants.primaryColor,
                              AppConstants.primaryColor.withOpacity(0.8),
                            ],
                          )
                        : null,
                    color: isFromPatient ? null : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isFromPatient ? 20 : 4),
                      bottomRight: Radius.circular(isFromPatient ? 4 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isFromPatient
                            ? AppConstants.primaryColor.withOpacity(0.3)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.message,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: isFromPatient ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    _formatMessageTime(message.time),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimestampDivider(String time) {
    final date = DateTime.parse(time);
    final now = DateTime.now();
    String displayText;

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      displayText = 'Today';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
      displayText = 'Yesterday';
    } else {
      displayText = '${date.day}/${date.month}/${date.year}';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            displayText,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String _formatMessageTime(String time) {
    final date = DateTime.parse(time);
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.grey[700]),
                onPressed: () {
                  // Add attachment functionality
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _textFieldFocus,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(
                  parent: _fabController,
                  curve: Curves.easeOutBack,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppConstants.primaryColor,
                      AppConstants.primaryColor.withOpacity(0.8),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: _isTyping
                      ? [
                          BoxShadow(
                            color: AppConstants.primaryColor.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: IconButton(
                  icon: Icon(
                    _isTyping ? Icons.send_rounded : Icons.mic_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      final chatBloc = BlocProvider.of<ChatBloc>(context);
                      chatBloc.add(SendMessage(
                          widget.doctorId, _messageController.text, widget.chatId));
                      _messageController.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageModel {
  final String senderName;
  final String time;
  final String message;

  MessageModel({
    required this.senderName,
    required this.time,
    required this.message,
  });
}