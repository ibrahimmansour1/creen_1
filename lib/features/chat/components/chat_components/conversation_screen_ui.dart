import 'dart:developer';

import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/chat/components/chat_components/components/bottom_send_navigation.dart';
import 'package:creen/features/chat/viewModel/chat/chat_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../follow/viewModel/followers/followers_cubit.dart';
import '../../../follow/viewModel/following/following_cubit.dart';
import '../../../profile/presentaion/pages/my_profile.dart';
import '../../../profile/viewModel/profile/profile_cubit.dart';

class ConversationScreen extends StatefulWidget {
  final String? username, profilePic, time;
  final bool? online;
  final bool isGroup;

  const ConversationScreen({
    Key? key,
    this.username,
    this.profilePic,
    this.time,
    this.online,
    required this.isGroup,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late ChatCubit chatCubit;

  @override
  void initState() {
    chatCubit = context.read<ChatCubit>()
      ..getChatsByRecieverId()
      ..initLink(
        context: context,
      );

    super.initState();
  }

  void openProfilePage() {
    log('messageFromOpenMethod');
    if (chatCubit.isGroup) {
      NavigationService.push(
        page: RoutePaths.groupDetails,
        isNamed: true,
      );
      return;
    }
    NavigationService.push(
      page: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => FollowingCubit(
              userId: chatCubit.recieverId,
            ),
          ),
          BlocProvider(
            create: (_) => FollowersCubit(
              userId: chatCubit.recieverId,
            ),
          ),
          BlocProvider(
            create: (_) => ProfileCubit(
              userId: chatCubit.recieverId,
            ),
          ),
        ],
        child: const MyProfileScreen(),
      ),
      isNamed: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(

      builder: (context, state) {
        // print("widget.profilePic    =====> ${widget.profilePic}\n\n\n\n\n\n\n\n\n");

        return Directionality(
          textDirection: HelperFunctions.isArabic?TextDirection.rtl:TextDirection.ltr,
          child: Scaffold(
            backgroundColor: const Color(0xfffaf0e6),
            appBar: AppBar(

              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MainStyle.primaryColor,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              title: state is ChatLoading
                  ? const SizedBox()
                  : Row(
                      children: [
                        InkWell(
                          onTap: () {
                            openProfilePage();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.profilePic==null?Colors.grey[200]
                                  : Colors.white,
                              image: DecorationImage(
                                image: HelperFunctions.chatProfileImage(
                                  isGroup: widget.isGroup,
                                  pic: widget.profilePic,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                openProfilePage();
                              },
                              child: BoxHelper(
                                width: 100,
                                child: Text(
                                  widget.username!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            /*widget.online!
                                ? Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 1),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      const Text(
                                        "Active Now",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                : */
                            Text(
                              widget.time ?? '',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.videocam, size: 20),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.call, size: 20),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
            body: const BottomSendNavigation(),
          ),
        );
      },
    );
  }
}
