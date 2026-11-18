// import 'package:flutter/material.dart';

// class ChatMessageInput extends StatelessWidget {
//   final TextEditingController messageController;
//   final FocusNode textFieldFocus;
//   final AnimationController fabController;
//   final bool isTyping;
//   final VoidCallback onSendPressed;

//   const ChatMessageInput({
//     super.key,
//     required this.messageController,
//     required this.textFieldFocus,
//     required this.fabController,
//     required this.isTyping,
//     required this.onSendPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         boxShadow: [
//           BoxShadow(
//             color: colorScheme.onSurface.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
//                 shape: BoxShape.circle,
//               ),
//               // child: IconButton(
//               //   icon: Icon(Icons.add, color: colorScheme.onSurfaceVariant),
//               //   onPressed: () {
//               //     // Add attachment functionality
//               //   },
//               // ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: TextField(
//                   controller: messageController,
//                   focusNode: textFieldFocus,
//                   maxLines: null,
//                   textCapitalization: TextCapitalization.sentences,
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: colorScheme.onSurface,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'Type a message...',
//                     hintStyle: theme.textTheme.bodyMedium?.copyWith(
//                       color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             ScaleTransition(
//               scale: Tween<double>(begin: 0.8, end: 1.0).animate(
//                 CurvedAnimation(
//                   parent: fabController,
//                   curve: Curves.easeOutBack,
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       colorScheme.primary,
//                       colorScheme.primaryContainer,
//                     ],
//                   ),
//                   shape: BoxShape.circle,
//                   boxShadow: isTyping
//                       ? [
//                           BoxShadow(
//                             color: colorScheme.primary.withValues(alpha: 0.4),
//                             blurRadius: 12,
//                             offset: const Offset(0, 4),
//                           ),
//                         ]
//                       : null,
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.send_rounded,
//                     color: colorScheme.onPrimary,
//                     size: 22,
//                   ),
//                   onPressed: onSendPressed,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:vistacall/utils/premium_theme.dart';

class ChatMessageInput extends StatelessWidget {
  final TextEditingController messageController;
  final FocusNode textFieldFocus;
  final AnimationController fabController;
  final bool isTyping;
  final VoidCallback onSendPressed;

  const ChatMessageInput({
    super.key,
    required this.messageController,
    required this.textFieldFocus,
    required this.fabController,
    required this.isTyping,
    required this.onSendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: const BoxDecoration(color: PremiumColors.surface),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              // Rebuilds only the pill when focus changes (gold border on focus).
              child: ListenableBuilder(
                listenable: textFieldFocus,
                builder: (context, child) {
                  final focused = textFieldFocus.hasFocus;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: focused
                            ? PremiumColors.accent.withValues(alpha: 0.85)
                            : PremiumColors.line,
                        width: focused ? 1.3 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: focused
                              ? PremiumColors.accent.withValues(alpha: 0.14)
                              : PremiumColors.navy800.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 5),
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: child,
                  );
                },
                child: TextField(
                  controller: messageController,
                  focusNode: textFieldFocus,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: PremiumColors.accent,
                  cursorWidth: 1.6,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: PremiumColors.ink,
                  ),
                  // Every border state is explicitly none so a global
                  // InputDecorationTheme can't draw an outline around the text.
                  decoration: InputDecoration(
                    filled: false,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: PremiumColors.muted.withValues(alpha: 0.75),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(
                  parent: fabController,
                  curve: Curves.easeOutBack,
                ),
              ),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: PremiumColors.navyGradient,
                  shape: BoxShape.circle,
                  boxShadow: isTyping
                      ? [
                          BoxShadow(
                            color: PremiumColors.navy800.withValues(alpha: 0.4),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                            spreadRadius: -2,
                          ),
                        ]
                      : null,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.send_rounded,
                    color: PremiumColors.accent,
                    size: 22,
                  ),
                  onPressed: onSendPressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}