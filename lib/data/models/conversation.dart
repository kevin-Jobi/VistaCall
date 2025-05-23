class Conversation {
  final String doctorName;
  final String lastMessage;
  final String timestamp;
  final bool isUnread;

  Conversation({
    required this.doctorName,
    required this.lastMessage,
    required this.timestamp,
    required this.isUnread,
  });
}