

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/chat/chat_bloc.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/presentation/widgets/chat/chat_app_bar.dart';
import 'package:vistacall/presentation/widgets/chat/chat_message_input.dart';
import 'package:vistacall/presentation/widgets/chat/chat_messages_stream.dart';

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

class _ChatDetailScreenState extends State<ChatDetailScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _textFieldFocus = FocusNode();
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

      print(
          'Query for unread messages returned ${querySnapshot.docs.length} documents');
      if (querySnapshot.docs.isNotEmpty) {
        final batch = _db.batch();
        for (var doc in querySnapshot.docs) {
          print('Updating message ${doc.id} with isRead: true');
          batch.update(doc.reference, {'isRead': true});
        }
        await batch.commit();
        print(
            'Marked ${querySnapshot.docs.length} messages as read for chat ${widget.chatId}');
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final patientId = _auth.currentUser?.uid ?? 'unknown';
    print('Building ChatDetailScreen - PatientID: $patientId');

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: ChatAppBar(
        doctorName: widget.doctorName,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessagesStream(
              patientId: patientId,
              chatId: widget.chatId,
              db: _db,
            ),
          ),
          ChatMessageInput(
            messageController: _messageController,
            textFieldFocus: _textFieldFocus,
            fabController: _fabController,
            isTyping: _isTyping,
            onSendPressed: () {
              if (_messageController.text.isNotEmpty) {
                final chatBloc = BlocProvider.of<ChatBloc>(context);
                chatBloc.add(SendMessage(
                    widget.doctorId, _messageController.text, widget.chatId));
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
