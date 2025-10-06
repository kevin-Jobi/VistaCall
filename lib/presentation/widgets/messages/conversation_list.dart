// import 'package:flutter/material.dart';
// import 'package:vistacall/data/models/conversation.dart';
// import 'package:vistacall/utils/constants.dart';

// class ConversationList extends StatelessWidget {
//   final List<Conversation> conversations;
//   final Function(Conversation) onConversationTap;

//   const ConversationList({
//     super.key,
//     required this.conversations,
//     required this.onConversationTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (conversations.isEmpty) {
//       return const Center(child: Text('No messages yet'));
//     }

//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       itemCount: conversations.length,
//       itemBuilder: (context, index) {
//         final conversation = conversations[index];
//         return _buildConversationTile(conversation, context);
//       },
//       separatorBuilder: (context, index) => const Divider(
//         height: 1,
//         thickness: 1,
//         color: Colors.grey,
//       ),
//     );
//   }

//   Widget _buildConversationTile(
//       Conversation conversation, BuildContext context) {
//         final formattedTime = _formatTimestamp(conversation.timestamp);
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.grey,
//         child: Text(conversation.doctorName.isNotEmpty
//             ? conversation.doctorName[0]
//             : '?'),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             conversation.doctorName,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(
//             formattedTime,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//       subtitle: Row(
//         children: [
//           if (conversation.isUnread)
//             Container(
//               margin: const EdgeInsets.only(right: 8),
//               width: 8,
//               height: 8,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppConstants.primaryColor,
//               ),
//             ),
//           Expanded(
//             child: Text(
//               conversation.lastMessage,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 color: conversation.isUnread ? Colors.black : Colors.grey,
//               ),
//             ),
//           ),
//         ],
//       ),
//       onTap: () => onConversationTap(conversation),
//     );
//   }

//   String _formatTimestamp(DateTime date) {
//   final now = DateTime.now();
//   if (date.year == now.year && date.month == now.month && date.day == now.day) {
//     return '${date.hour}:${date.minute}'.padLeft(5, '0');
//   } else if (date.year == now.year && date.month == now.month && date.day == now.day - 1) {
//     return 'Yesterday';
//   } else {
//     return '${date.day}/${date.month}';
//   }
// }
// }


import 'package:flutter/material.dart';
import 'package:vistacall/data/models/conversation.dart';
import 'package:vistacall/utils/constants.dart';

class ConversationList extends StatelessWidget {
  final List<Conversation> conversations;
  final Function(Conversation) onConversationTap;

  const ConversationList({
    super.key,
    required this.conversations,
    required this.onConversationTap,
  });

  @override
  Widget build(BuildContext context) {
    if (conversations.isEmpty) {
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
                size: 64,
                color: AppConstants.primaryColor.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No conversations yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a conversation with a doctor',
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return _buildConversationTile(conversation, context);
      },
    );
  }

  Widget _buildConversationTile(Conversation conversation, BuildContext context) {
    final formattedTime = _formatTimestamp(conversation.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: conversation.isUnread 
            ? AppConstants.primaryColor.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onConversationTap(conversation),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Avatar with online indicator
                Stack(
                  children: [
                    Hero(
                      tag: 'avatar_${conversation.doctorName}',
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppConstants.primaryColor,
                              AppConstants.primaryColor.withOpacity(0.7),
                            ],
                          ),
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
                            conversation.doctorName.isNotEmpty
                                ? conversation.doctorName[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              conversation.doctorName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: conversation.isUnread 
                                    ? FontWeight.w700 
                                    : FontWeight.w600,
                                color: Colors.grey[900],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: conversation.isUnread
                                  ? AppConstants.primaryColor.withOpacity(0.1)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: conversation.isUnread
                                    ? AppConstants.primaryColor
                                    : Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation.lastMessage,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.3,
                                color: conversation.isUnread
                                    ? Colors.grey[800]
                                    : Colors.grey[600],
                                fontWeight: conversation.isUnread
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (conversation.isUnread) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppConstants.primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppConstants.primaryColor.withOpacity(0.4),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Text(
                                '•',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime date) {
    final now = DateTime.now();
    
    if (date.year == now.year && 
        date.month == now.month && 
        date.day == now.day) {
      final hour = date.hour.toString().padLeft(2, '0');
      final minute = date.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else if (date.year == now.year && 
               date.month == now.month && 
               date.day == now.day - 1) {
      return 'Yesterday';
    } else if (date.year == now.year) {
      return '${date.day}/${date.month}';
    } else {
      return '${date.day}/${date.month}/${date.year.toString().substring(2)}';
    }
  }
}