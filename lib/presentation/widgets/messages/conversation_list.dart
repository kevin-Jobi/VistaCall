// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
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
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: AppConstants.primaryColor.withValues(alpha: .1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.chat_bubble_outline_rounded,
//                 size: 64,
//                 color: AppConstants.primaryColor.withValues(alpha: .6),
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               'No conversations yet',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[800],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Start a conversation with a doctor',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       itemCount: conversations.length,
//       itemBuilder: (context, index) {
//         final conversation = conversations[index];
//         return _buildConversationTile(conversation, context);
//       },
//     );
//   }

//   Widget _buildConversationTile(
//       Conversation conversation, BuildContext context) {
//     final formattedTime = _formatTimestamp(conversation.timestamp);

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       decoration: BoxDecoration(
//         color: conversation.isUnread
//             ? AppConstants.primaryColor.withValues(alpha: .05)
//             : Colors.transparent,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => onConversationTap(conversation),
//           borderRadius: BorderRadius.circular(16),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 // Avatar with online indicator
//                 Stack(
//                   children: [
//                     Hero(
//                       tag: 'avatar_${conversation.doctorName}',
//                       child: Container(
//                         width: 56,
//                         height: 56,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: LinearGradient(
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                             colors: [
//                               AppConstants.primaryColor,
//                               AppConstants.primaryColor.withValues(alpha: .7),
//                             ],
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppConstants.primaryColor
//                                   .withValues(alpha: .3),
//                               blurRadius: 8,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             conversation.doctorName.isNotEmpty
//                                 ? conversation.doctorName[0].toUpperCase()
//                                 : '?',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 2,
//                       bottom: 2,
//                       child: Container(
//                         width: 14,
//                         height: 14,
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white, width: 2),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 14),
//                 // Content
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               conversation.doctorName,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: conversation.isUnread
//                                     ? FontWeight.w700
//                                     : FontWeight.w600,
//                                 color: Colors.grey[900],
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: conversation.isUnread
//                                   ? AppConstants.primaryColor
//                                       .withValues(alpha: .1)
//                                   : Colors.grey[100],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               formattedTime,
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w600,
//                                 color: conversation.isUnread
//                                     ? AppConstants.primaryColor
//                                     : Colors.grey[600],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               conversation.lastMessage,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 height: 1.3,
//                                 color: conversation.isUnread
//                                     ? Colors.grey[800]
//                                     : Colors.grey[600],
//                                 fontWeight: conversation.isUnread
//                                     ? FontWeight.w500
//                                     : FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                           if (conversation.isUnread) ...[
//                             const SizedBox(width: 8),
//                             Container(
//                               padding: const EdgeInsets.all(6),
//                               decoration: BoxDecoration(
//                                 color: AppConstants.primaryColor,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: AppConstants.primaryColor
//                                         .withValues(alpha: .4),
//                                     blurRadius: 4,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: const Text(
//                                 '•',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatTimestamp(DateTime date) {
//     final now = DateTime.now();

//     if (date.year == now.year &&
//         date.month == now.month &&
//         date.day == now.day) {
//       // Use 12-hour format with am/pm
//       return DateFormat('h:mm a').format(date);
//     } else if (date.year == now.year &&
//         date.month == now.month &&
//         date.day == now.day - 1) {
//       return 'Yesterday';
//     } else if (date.year == now.year) {
//       // return '${date.day}/${date.month}';
//       return DateFormat('d MMM').format(date);
//     } else {
//       // return '${date.day}/${date.month}/${date.year.toString().substring(2)}';
//       return  DateFormat('d MMM yyyy').format(date);
//     }
//   }
// }





import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vistacall/data/models/conversation.dart';
import 'package:vistacall/utils/premium_theme.dart';

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
      return const ConversationEmptyState();
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      // Extra bottom space so the last tile clears the floating nav bar.
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 130),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return _buildConversationTile(conversation, context);
      },
    );
  }

  Widget _buildConversationTile(
      Conversation conversation, BuildContext context) {
    final formattedTime = _formatTimestamp(conversation.timestamp);
    final unread = conversation.isUnread;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: unread
              ? PremiumColors.accent.withValues(alpha: 0.6)
              : PremiumColors.line,
          width: unread ? 1.2 : 1,
        ),
        boxShadow: PremiumColors.softShadow(unread ? 0.09 : 0.06),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onConversationTap(conversation),
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(14),
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
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: PremiumColors.navyGradient,
                          border: Border.all(
                            color: unread
                                ? PremiumColors.accent
                                : Colors.white.withValues(alpha: 0.18),
                            width: unread ? 1.5 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: PremiumColors.navy800
                                  .withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: Text(
                          conversation.doctorName.isNotEmpty
                              ? premiumInitials(conversation.doctorName)
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF34C38F),
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
                                fontSize: 15.5,
                                fontWeight:
                                    unread ? FontWeight.w800 : FontWeight.w700,
                                letterSpacing: -0.1,
                                color: PremiumColors.ink,
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
                              color: unread
                                  ? PremiumColors.accent.withValues(alpha: 0.16)
                                  : PremiumColors.navy800
                                      .withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              formattedTime,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: unread
                                    ? PremiumColors.navy800
                                    : PremiumColors.muted,
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
                                fontSize: 13.5,
                                height: 1.35,
                                color: unread
                                    ? PremiumColors.ink
                                    : PremiumColors.muted,
                                fontWeight:
                                    unread ? FontWeight.w500 : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (unread) ...[
                            const SizedBox(width: 10),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: PremiumColors.accent,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: PremiumColors.accent
                                        .withValues(alpha: 0.45),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
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
      // Use 12-hour format with am/pm
      return DateFormat('h:mm a').format(date);
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    } else if (date.year == now.year) {
      // return '${date.day}/${date.month}';
      return DateFormat('d MMM').format(date);
    } else {
      // return '${date.day}/${date.month}/${date.year.toString().substring(2)}';
      return DateFormat('d MMM yyyy').format(date);
    }
  }
}

/// Premium empty state, also used by MessagesScreen for its own empty case.
class ConversationEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const ConversationEmptyState({
    super.key,
    this.title = 'No conversations yet',
    this.subtitle = 'Start a conversation with a doctor',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PremiumColors.navy800.withValues(alpha: 0.06),
              ),
              child: Center(
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: PremiumColors.navyGradient,
                    border: Border.all(
                      color: PremiumColors.accent.withValues(alpha: 0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PremiumColors.navy800.withValues(alpha: 0.25),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 36,
                    color: PremiumColors.accent,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: PremiumColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.45,
                color: PremiumColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}