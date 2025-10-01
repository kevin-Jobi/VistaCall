import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistacall/bloc/messages/messages_bloc.dart';
import 'package:vistacall/bloc/messages/messages_event.dart';
import 'package:vistacall/bloc/messages/messages_state.dart';
import 'package:vistacall/presentation/widgets/custom_bottom_navbar.dart';
import 'package:vistacall/presentation/widgets/messages/conversation_list.dart';
import 'package:vistacall/presentation/widgets/messages/messages_app_bar.dart';
import 'package:vistacall/viewmodels/messages_viewmodel.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messagesBloc = BlocProvider.of<MessagesBloc>(context);
    messagesBloc.add(LoadMessagesEvent()); // Trigger loading once

    final viewModel = MessagesViewModel(messagesBloc);

    return Scaffold(
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
          return const Center(child: CircularProgressIndicator());
        }
        final error = viewModel.getError(state);
        if (error != null) {
          return Center(child: Text(error));
        }

        final conversations = viewModel.getConversations(state);
        if (conversations.isEmpty) {
          return const Center(child: Text('No conversations available'));
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
