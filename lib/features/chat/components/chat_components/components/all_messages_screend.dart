import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewModel/allConversations/all_conversations_cubit.dart';
import '../../../viewModel/chat/chat_cubit.dart';
import '../conversation_screen_ui.dart';

class AllMessagesScreen extends StatelessWidget {
  const AllMessagesScreen({
    Key? key,
    required this.allConversationsCubit,
    this.isGroup = false,
    required this.recieverId,
    required this.conversationId,
    required this.userName,
    required this.profilePic,
    required this.timeAgo,
  }) : super(key: key);
  final int? recieverId;
  final bool isGroup;
  final int? conversationId;
  final AllConversationsCubit allConversationsCubit;
  final String? userName, profilePic, timeAgo;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit(
            isGroup: isGroup, //conversation.teamCode != null,
            conversationId: conversationId, //conversation.id,
            recieverId: recieverId,
          ),
        ),
        BlocProvider.value(
          value: allConversationsCubit,
        ),
      ],
      child: ConversationScreen(
        isGroup: isGroup,
        profilePic: profilePic,
        username: userName,
        online: true,
        time: timeAgo,
      ),
    );
  }
}
