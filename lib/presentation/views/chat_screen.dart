import 'package:flutter/material.dart';
import 'package:vistacall/presentation/widgets/chat/chatDetailScreen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming chatId or doctorId is passed via route arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final doctorId = args?['doctorId'] as String? ?? '';
    final doctorName = args?['doctorName'] as String? ?? 'Unknown Doctor';
    final patientName = args?['patientName'] as String? ?? '';

    if (doctorId.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No doctor selected')),
      );
    }

    final chatId = _getChatId(patientName, doctorId);

    return ChatDetailScreen(
      doctorId: doctorId,
      doctorName: doctorName,
      chatId: chatId,
    );
  }

  String _getChatId(String patientName, String doctorId) {
    return patientName.compareTo(doctorId) < 0
        ? '$patientName-$doctorId'
        : '$doctorId-$patientName';
  }
}
