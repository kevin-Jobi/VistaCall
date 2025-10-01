class Conversation {
  final String doctorName;
  final String lastMessage;
  final String timestamp;
  final bool isUnread;
  final String doctorId; // Added field
  final String chatId;

  Conversation({
    required this.doctorName,
    required this.lastMessage,
    required this.timestamp,
    required this.isUnread,
    required this.doctorId, // Added parameter
    required this.chatId,
  });
}