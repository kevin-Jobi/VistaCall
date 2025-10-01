// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/chat/chat_bloc.dart';
// import 'package:vistacall/bloc/chat/chat_event.dart';
// import 'package:vistacall/bloc/chat/chat_state.dart';
// import 'package:vistacall/presentation/widgets/chat/chat_app_bar.dart';
// import 'package:vistacall/presentation/widgets/chat/message_input.dart';
// import 'package:vistacall/presentation/widgets/chat/message_list.dart';
// import 'package:vistacall/viewmodels/chat_viewmodel.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final chatBloc = BlocProvider.of<ChatBloc>(context);
//     final TextEditingController _controller = TextEditingController();
//     chatBloc.add(LoadChatEvent());
//     final viewModel = ChatViewModel(chatBloc)..loadMessages();

//     return Scaffold(
//       appBar: const ChatAppBar(),

//       body: _buildBody(context, viewModel),

//     );
//   }

//     Widget _buildBody(BuildContext context, ChatViewModel viewModel) {
//     return BlocBuilder<ChatBloc, ChatState>(
//       builder: (context, state) {
//         if (viewModel.isLoading(state)) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final error = viewModel.getError(state);
//         if (error != null) {
//           return Center(child: Text(error));
//         }

//         return Column(
//           children: [
//             Expanded(
//               child: MessageList(messages: viewModel.getMessages(state)),
//             ),
//             MessageInput(onSend: viewModel.sendMessage),
//           ],
//         );
//       },
//     );
//   }
// }

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
    return patientName.compareTo(doctorId)<0
        ? '$patientName-$doctorId'
        : '$doctorId-$patientName';
  }
}
