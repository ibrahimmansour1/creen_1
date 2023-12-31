import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/chat/viewModel/allConversations/all_conversations_cubit.dart';
import '../../../features/chat/whatsapp_home.dart';

class AllConversationsScreen extends StatelessWidget {
  const AllConversationsScreen({
    Key? key,
    this.link,
  }) : super(key: key);
  final String? link;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllConversationsCubit(
            link: link,
          ),
        ),
        BlocProvider(create: (context) => StoriesCubit()),
      ],
      child: const WhatsappHome(),
    );
  }
}
