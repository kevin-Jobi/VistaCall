// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_bloc.dart';
// import 'package:vistacall/bloc/messages/messages_event.dart';
// import 'package:vistacall/bloc/messages/messages_state.dart';
// import 'package:vistacall/presentation/widgets/custom_widgets/custom_bottom_navbar.dart';
// import 'package:vistacall/presentation/widgets/messages/conversation_list.dart';
// import 'package:vistacall/presentation/widgets/messages/messages_app_bar.dart';
// import 'package:vistacall/viewmodels/messages_viewmodel.dart';

// class MessagesScreen extends StatelessWidget {
//   const MessagesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final messagesBloc = BlocProvider.of<MessagesBloc>(context);
//     messagesBloc.add(LoadMessagesEvent()); // Trigger loading once

//     final viewModel = MessagesViewModel(messagesBloc);

//     return Scaffold(
//       appBar: const MessagesAppBar(),
//       body: _buildBody(context, viewModel),
//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: 2,
//         onTap: (index) => viewModel.handleNavigation(index, context),
//       ),
//     );
//   }

//   Widget _buildBody(BuildContext context, MessagesViewModel viewModel) {
//     return BlocBuilder<MessagesBloc, MessagesState>(
//       builder: (context, state) {
//         print(
//             'MessagesScreen: State - ${state.runtimeType}, Conversations: ${viewModel.getConversations(state).length}');
//         if (viewModel.isLoading(state)) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final error = viewModel.getError(state);
//         if (error != null) {
//           return Center(child: Text(error));
//         }

//         final conversations = viewModel.getConversations(state);
//         if (conversations.isEmpty) {
//           return const Center(child: Text('No conversations available'));
//         }

//         return ConversationList(
//           conversations: conversations,
//           onConversationTap: (conversation) {
//             print(
//                 'Tapped conversation - DoctorID: ${conversation.doctorId}, DoctorName: ${conversation.doctorName}');

//             viewModel.handleConversationTap(context, conversation);
//           },
//         );
//       },
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/bloc/messages/messages_state.dart';
import 'package:vistacall/presentation/widgets/custom_widgets/custom_bottom_navbar.dart';
import 'package:vistacall/presentation/widgets/messages/conversation_list.dart';
import 'package:vistacall/presentation/widgets/messages/messages_app_bar.dart';
import 'package:vistacall/utils/premium_theme.dart';
import 'package:vistacall/viewmodels/messages_viewmodel.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messagesBloc = BlocProvider.of<MessagesBloc>(context);
    messagesBloc.add(LoadMessagesEvent()); // Trigger loading once

    final viewModel = MessagesViewModel(messagesBloc);

    return Scaffold(
      backgroundColor: PremiumColors.surface,
      extendBody: true, // list scrolls behind the floating nav bar
      appBar: const MessagesAppBar(),
      body: _buildBody(context, viewModel),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) => viewModel.handleNavigation(index, context),
      ),
    );
  }

  Widget _buildBody(BuildContext context, MessagesViewModel viewModel) {
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (context, state) {
        print(
            'MessagesScreen: State - ${state.runtimeType}, Conversations: ${viewModel.getConversations(state).length}');
        if (viewModel.isLoading(state)) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: PremiumColors.line),
                boxShadow: PremiumColors.softShadow(0.10),
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor:
                    AlwaysStoppedAnimation<Color>(PremiumColors.navy600),
              ),
            ),
          );
        }
        final error = viewModel.getError(state);
        if (error != null) {
          return Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                    color: PremiumColors.danger.withValues(alpha: 0.25)),
                boxShadow: PremiumColors.softShadow(0.07),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: PremiumColors.danger.withValues(alpha: 0.08),
                    ),
                    child: const Icon(
                      Icons.error_outline_rounded,
                      color: PremiumColors.danger,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                      color: PremiumColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final conversations = viewModel.getConversations(state);
        if (conversations.isEmpty) {
          return const ConversationEmptyState(
            title: 'No conversations available',
          );
        }

        return ConversationList(
          conversations: conversations,
          onConversationTap: (conversation) {
            print(
                'Tapped conversation - DoctorID: ${conversation.doctorId}, DoctorName: ${conversation.doctorName}');

            viewModel.handleConversationTap(context, conversation);
          },
        );
      },
    );
  }
}