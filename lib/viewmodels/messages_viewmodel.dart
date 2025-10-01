
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_event.dart';
// import 'package:vistacall/bloc/messages/messages_state.dart';
// import 'package:vistacall/data/models/conversation.dart';
// import 'package:vistacall/presentation/widgets/chat/chatDetailScreen.dart';
// import 'package:vistacall/utils/constants.dart';

// class MessagesViewModel {
//   final MessagesBloc _messagesBloc;

//   MessagesViewModel(this._messagesBloc);

//   // State management methods
//   bool isLoading(MessagesState state) => state is MessagesLoadingState;
//   String? getError(MessagesState state) => state is MessagesErrorState ? state.error : null;
//   List<Conversation> getConversations(MessagesState state) => 
//       state is MessagesLoadedState ? state.conversations : [];

//   // Action methods
//   void loadMessages() => _messagesBloc.add(LoadMessagesEvent());
  
//   // void handleConversationTap(BuildContext context, Conversation conversation) {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text('Chat with ${conversation.doctorName} coming soon!')),
//   //   );
//   // }

// void handleConversationTap(BuildContext context, Conversation conversation) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ChatDetailScreen(
//         doctorId: conversation.doctorId, // Add doctorId to Conversation model
//         doctorName: conversation.doctorName,
//       ),
//     ),
//   );
// }
//   void handleNavigation(int index, BuildContext context) {
//     if (index == 0) {
//       Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
//     } else if (index == 1) {
//       Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
//     } else if (index == 3) {
//       Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/bloc/messages/messages_state.dart';
import 'package:vistacall/data/models/conversation.dart';
import 'package:vistacall/utils/constants.dart';

class MessagesViewModel {
  final MessagesBloc _messagesBloc;

  MessagesViewModel(this._messagesBloc);

  // State management methods
  bool isLoading(MessagesState state) => state is MessagesLoadingState;
  String? getError(MessagesState state) => state is MessagesErrorState ? state.error : null;
  List<Conversation> getConversations(MessagesState state) => 
      state is MessagesLoadedState ? state.conversations : [];

  // Action methods
  void loadMessages() => _messagesBloc.add(LoadMessagesEvent());
  
  // void handleConversationTap(BuildContext context, Conversation conversation) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ChatDetailScreen(
  //         doctorId: conversation.doctorId,
  //         doctorName: conversation.doctorName,
  //       ),
  //     ),
  //   );
  // }

void handleConversationTap(BuildContext context, Conversation conversation) {
  print('Navigating to ChatDetailScreen - DoctorID: ${conversation.doctorId}, DoctorName: ${conversation.doctorName}');
  Navigator.pushNamed(
    context,
    AppConstants.chatDetailRoute,
    arguments: {
      'doctorId': conversation.doctorId,
      'doctorName': conversation.doctorName,
      'chatId': conversation.chatId,
    },
  );
}

  void handleNavigation(int index, BuildContext context) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, AppConstants.appointmentsRoute);
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, AppConstants.profileRoute);
    }
  }
}