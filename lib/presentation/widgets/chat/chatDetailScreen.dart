import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _textFieldFocus = FocusNode();
  DateTime? _lastDisplayedDate;

  @override
  void initState() {
    super.initState();
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final patientId = _auth.currentUser?.uid ?? 'unknown';
    // _getPatientNameFromUid(patientId).then((patientName) {
    //   final chatId = _getChatId(patientName, widget.doctorId);
    //   print(
    //       'Initializing ChatDetailScreen - PatientID: $patientId, PatientName: $patientName, DoctorID: ${widget.doctorId}, ChatID: $chatId');
    //   chatBloc.add(LoadChatMessages(widget.doctorId));
    // });
    chatBloc.add(LoadChatMessages(widget.doctorId, widget.chatId));
  }

  Future<String> _getPatientNameFromUid(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data()?['name'] ?? 'Jeswin'; // Default to "Jeswin"
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientId = _auth.currentUser?.uid ?? 'unknown';
    print('Building ChatDetailScreen - PatientID: $patientId');

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          _buildDoctorAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctorName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorAvatar() {
    final initials = _getInitials(widget.doctorName);
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
          print(
              'No snapshot data - Connection state: ${snapshot.connectionState}, Error: ${snapshot.error}');
          return const Center(child: CircularProgressIndicator());
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
          print(
              'Message data: senderId: $senderId, message: ${data['message']}, time: $time');
          return MessageModel(
            senderName: senderName,
            time: time,
            message: data['message'] ?? 'No message',
          );
        }).toList();

        print('Total messages fetched: ${messages.length}');
        if (messages.isEmpty) {
          print('No messages found in ChatID: $chatId');
          return const Center(
            child: Text('No messages yet'),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          reverse: true,
          padding: const EdgeInsets.all(16),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final showTimestamp = _shouldShowTimestamp(messages, index);
            return _buildMessageBubble(message, showTimestamp);
          },
        );
      },
    );
  }

  bool _shouldShowTimestamp(List<MessageModel> messages, int index) {
    if (index == 0) return true;
    final currentDate = DateTime.parse(messages[index].time);
    final prevDate = DateTime.parse(messages[index - 1].time);
    return !currentDate.isAtSameMomentAs(prevDate);
  }

  Widget _buildMessageBubble(MessageModel message, bool showTimestamp) {
    final isFromPatient = message.senderName == 'You';
    return Column(
      crossAxisAlignment:
          isFromPatient ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (showTimestamp) _buildTimestampDivider(message.time),
        Container(
          margin: EdgeInsets.only(
            bottom: 8,
            left: isFromPatient ? 60 : 0,
            right: isFromPatient ? 0 : 60,
          ),
          child: Column(
            crossAxisAlignment: isFromPatient
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isFromPatient
                      ? AppConstants.primaryColor
                      : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: Radius.circular(isFromPatient ? 12 : 4),
                    bottomRight: Radius.circular(isFromPatient ? 4 : 12),
                  ),
                ),
                child: Text(
                  message.message,
                  style: TextStyle(
                    fontSize: 15,
                    color: isFromPatient ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              Text(
                _formatMessageTime(message.time),
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimestampDivider(String time) {
    final date = DateTime.parse(time);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '${date.day}/${date.month}/${date.year}',
        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
      ),
    );
  }

  String _formatMessageTime(String time) {
    final date = DateTime.parse(time);
    return '${date.hour}:${date.minute}'.padLeft(5, '0');
  }



  // Widget _buildMessageInput() {
  //   return Container(
  //     padding: const EdgeInsets.all(8),
  //     color: Colors.white,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             controller: _messageController,
  //             focusNode: _textFieldFocus,
  //             decoration: InputDecoration(
  //               hintText: 'Type a message...',
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(25),
  //                 borderSide: BorderSide.none,
  //               ),
  //               filled: true,
  //               fillColor: Colors.grey[200],
  //             ),
  //           ),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.send, color: Colors.blue),
  //           onPressed: () {
  //             if (_messageController.text.isNotEmpty) {
  //               final chatBloc = BlocProvider.of<ChatBloc>(context);
  //               chatBloc.add(SendMessage(
  //                   widget.doctorId, _messageController.text, widget.chatId));
  //               _messageController.clear();
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildMessageInput() {
  return Container(
    padding: const EdgeInsets.all(8),
    color: Colors.white,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            focusNode: _textFieldFocus,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.blue),
          onPressed: () {
            if (_messageController.text.isNotEmpty) {
              final chatBloc = BlocProvider.of<ChatBloc>(context);
              chatBloc.add(SendMessage(
                  widget.doctorId, _messageController.text, widget.chatId));

              // Listen for ChatMessageSent and reload MessagesBloc
              chatBloc.stream.listen((state) {
                if (state is ChatMessageSent) {
                  final messagesBloc = BlocProvider.of<MessagesBloc>(context, listen: false);
                  messagesBloc.add(LoadMessagesEvent());
                }
              });
              _messageController.clear();
            }
          },
        ),
      ],
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
