

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vistacall/presentation/views/chatDetailScreen.dart';

class ChatMessagesStream extends StatelessWidget {
  final String patientId;
  final String chatId;
  final FirebaseFirestore db;

  const ChatMessagesStream({
    super.key,
    required this.patientId,
    required this.chatId,
    required this.db,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    print('Streaming from ChatID: $chatId');
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print(
              'No snapshot data - Connection state: ${snapshot.connectionState}, Error: ${snapshot.error}');
          return Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          );
        }
        if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.error,
              ),
            ),
          );
        }

        final messages = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final timestamp = data['timestamp'] as Timestamp?;
          final senderId = data['senderId'] as String? ?? 'Unknown';
          final isPatient = senderId == patientId;
          final senderName = isPatient ? 'You' : 'Doctor';
          final time = timestamp?.toDate().toLocal().toIso8601String() ??
              DateTime.now().toIso8601String();
          final isRead = data['isRead'] ?? false;
          print(
              'Message data: senderId: $senderId, message: ${data['message']}, time: $time, isRead: $isRead');
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
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 56,
                    color: colorScheme.primary.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'No messages yet',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start the conversation',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final showTimestamp = _shouldShowTimestamp(messages, index);
            return _buildMessageBubble(message, showTimestamp, index, theme, colorScheme);
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

  Widget _buildMessageBubble(
      MessageModel message, bool showTimestamp, int index, ThemeData theme, ColorScheme colorScheme) {
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
          if (showTimestamp) _buildTimestampDivider(message.time, theme, colorScheme),
          Container(
            margin: EdgeInsets.only(
              bottom: 12,
              left: isFromPatient ? 60 : 0,
              right: isFromPatient ? 0 : 60,
            ),
            child: Column(
              crossAxisAlignment:
                  isFromPatient ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isFromPatient
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorScheme.primary,
                              colorScheme.primaryContainer,
                            ],
                          )
                        : null,
                    color: isFromPatient ? null : colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isFromPatient ? 20 : 4),
                      bottomRight: Radius.circular(isFromPatient ? 4 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isFromPatient
                            ? colorScheme.primary.withValues(alpha: 0.3)
                            : colorScheme.onSurface.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: isFromPatient ? colorScheme.onPrimary : colorScheme.onSurface,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    _formatMessageTime(message.time),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
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

  Widget _buildTimestampDivider(String time, ThemeData theme, ColorScheme colorScheme) {
    final date = DateTime.parse(time);
    final now = DateTime.now();
    String displayText;

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      displayText = 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
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
            color: colorScheme.surfaceVariant.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            displayText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String _formatMessageTime(String time) {
    final date = DateTime.parse(time);
    return DateFormat('h:mm a').format(date);
  }
}