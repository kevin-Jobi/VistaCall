import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.05),
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
                color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              // child: IconButton(
              //   icon: Icon(Icons.add, color: colorScheme.onSurfaceVariant),
              //   onPressed: () {
              //     // Add attachment functionality
              //   },
              // ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: messageController,
                  focusNode: textFieldFocus,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
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
                  parent: fabController,
                  curve: Curves.easeOutBack,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      colorScheme.primaryContainer,
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: isTyping
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    color: colorScheme.onPrimary,
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