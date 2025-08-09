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
      return const Center(child: Text('No messages yet'));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return _buildConversationTile(conversation, context);
      },
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildConversationTile(
      Conversation conversation, BuildContext context) {
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
      onTap: () => onConversationTap(conversation),
    );
  }
}
