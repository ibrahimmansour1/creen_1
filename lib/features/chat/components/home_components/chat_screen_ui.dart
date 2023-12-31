// import 'dart:developer';

import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';

// import 'package:creen/features/chat/model/chat_model.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/enums.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/widgets/custom_awesome_dialog.dart';
import '../../../../core/utils/widgets/report_dialog.dart';
import '../../../block/cubit/bloc_cubit.dart';
import '../../../reports/viewModel/createReport/create_report_cubit.dart';
import '../../repo/chat_repo.dart';
import '../../viewModel/allConversations/all_conversations_cubit.dart';
import '../chat_components/components/all_messages_screend.dart';

class ChatScreenUI extends StatelessWidget {
  const ChatScreenUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allConversationsCubit = context.read<AllConversationsCubit>();
    return BlocConsumer<AllConversationsCubit, AllConversationsState>(
      listener: (context, state) {
        if (state is CreateTeamDone) {
          allConversationsCubit.getAllConversations(init: true);
        }
      },
      builder: (context, state) {
        if (state is AllConversationsLoading) {
          return const LoaderWidget(color: Colors.white);
        }

        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Directionality(
                textDirection: localization.currentLanguage.toString() == "en"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                    child: allConversationsCubit.conversations.isEmpty
                        ? Center(
                            child: Text(
                              'conversations_empty'.translate,
                              style: MainTheme.authTextStyle,
                            ),
                          )
                        : ListView.builder(
                            controller: allConversationsCubit.scrollController,
                            primary: false,
                            shrinkWrap: true,
                            itemCount:
                                allConversationsCubit.conversations.length,
                            itemBuilder: (context, i) {
                              var conversation =
                                  allConversationsCubit.conversations[i];
                              // var userId = conversation.userId;
                              var isGroup = conversation.teamCode != null;
                              var userName = conversation.name ??
                                  ((conversation.recieverm?.id ==
                                          HelperFunctions.currentUser!.id)
                                      ? (conversation.sender?.name ?? '')
                                      : (conversation.recieverm?.name ?? ''));

                              var pic = conversation.logo ??
                                  ((conversation.recieverm?.id ==
                                          HelperFunctions.currentUser!.id)
                                      ? (conversation.sender?.profile ?? null)
                                      : (conversation.recieverm?.profile ??
                                          null));
                              // print("pic ===> ${pic}\n\n\n\n\n\n\n\n\n");

                              // log('userID => ${conversation.teamCode.runtimeType} ${conversation.name} isTeam ${conversation.teamCode != null}');
                              // log('conversation $i ${conversation}');
                              return Column(
                                children: [
                                 /* ListTile(
                                    onTap: () {
                                      // log('')
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return AllMessagesScreen(
                                              isGroup: isGroup,
                                              allConversationsCubit:
                                                  allConversationsCubit,
                                              conversationId: conversation.id,
                                              profilePic: pic,
                                              recieverId:
                                                  conversation.reciever ??
                                                      conversation.id,
                                              // int.tryParse(
                                              //     conversation.teamCode ??
                                              //         ''),
                                              timeAgo: conversation
                                                  .lmessage?.timeAgo,
                                              userName: userName,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      CustomAwesomeDialog().showOptionsDialog(
                                        context: context,
                                        message: 'block_chat_confirm'.translate,
                                        btnOkText: 'block',
                                        btnCancelText: 'cancel',
                                        onConfirm: () {
                                          submitBlock(
                                              blockType: ReportType.chat,
                                              blockTypeId: conversation.id!);
                                        },
                                        type: DialogType.warning,
                                      );
                                    },
                                    leading: CircleAvatar(
                                      radius: 25.r,
                                      // backgroundColor: Colors.green,
                                      child: CircleAvatar(
                                        backgroundColor: (conversation
                                                        .recieverm?.profile ==
                                                    null &&
                                                conversation.sender?.profile ==
                                                    null)
                                            ? Colors.grey[200]
                                            : Colors.white,
                                        backgroundImage: conversation
                                                    .recieverm?.id ==
                                                HelperFunctions.currentUser!.id
                                            ? (HelperFunctions.chatProfileImage(
                                                isGroup: isGroup,
                                                pic: conversation.sender
                                                    ?.profile *//*??
                                                  conversation.logo*//*
                                                ,
                                              ))
                                            : (HelperFunctions.chatProfileImage(
                                                isGroup: isGroup,
                                                pic: conversation.recieverm
                                                    ?.profile *//*??
                                                  conversation.logo*//*
                                                ,
                                              )),
                                        radius: 24.r,
                                        child:
                                            null *//* conversation.recieverm?.profile ==null?AssetImage(
                                          'assets/images/${isGroup ? 'new_group_icon.png' : 'person_perview.png'}',
                                          fit: BoxFit.cover,

                                        ):null*//*
                                        ,

                                        // child: dummyData[i].online!
                                        //     ? Container(
                                        //         margin: const EdgeInsets.only(
                                        //             bottom: 40, right: 40),
                                        //         width: 20,
                                        //         height: 20,
                                        //         decoration: BoxDecoration(
                                        //           color: Colors.green,
                                        //           shape: BoxShape.circle,
                                        //           border: Border.all(
                                        //             width: 2,
                                        //             color: Colors.white,
                                        //           ),
                                        //         ),
                                        //       )
                                        //     : Container(),
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          userName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          conversation.timeAgo ?? '',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            if (conversation.lmessage?.userId ==
                                                HelperFunctions.currentUser?.id)
                                              Icon(
                                                Icons.done_all,
                                                size: 18,
                                                color: Colors.blue[600],
                                              ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                conversation.lmessage
                                                        ?.description ??
                                                    '_',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            *//**
                                          if (!dummyData[i].seen!)
                                          Container(
                                          height: 15,
                                          width: 15,
                                          decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          ),
                                          child: const Align(
                                          child: Text(
                                          "1",
                                          style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          ),
                                          ),
                                          ),
                                          ),
                                       *//*
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),*/
                                  ListTile(
                                    onTap: () {
                                      // log('')
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return AllMessagesScreen(
                                              isGroup: isGroup,
                                              allConversationsCubit:
                                              allConversationsCubit,
                                              conversationId: conversation.id,
                                              profilePic: pic,
                                              recieverId:
                                              conversation.reciever ??
                                                  conversation.id,
                                              // int.tryParse(
                                              //     conversation.teamCode ??
                                              //         ''),
                                              timeAgo: conversation
                                                  .lmessage?.timeAgo,
                                              userName: userName,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                   /*   CustomAwesomeDialog().showOptionsDialog(
                                        context: context,
                                        message: 'block_chat_confirm'.translate,
                                        btnOkText: 'block',
                                        btnCancelText: 'cancel',
                                        onConfirm: () {
                                          submitBlock(
                                              blockType: ReportType.chat,
                                              blockTypeId: conversation.id!);
                                        },
                                        type: DialogType.warning,
                                      );*/

                                      showMenu(
                                        context: context,
                                        position: RelativeRect.fromLTRB(100, 280, 200, 330), // Adjust the position as needed
                                        items: <PopupMenuEntry>[
                                           HelperFunctions.buildPopupMenu(
                                                icons: Icons.delete, title: 'delete', value: 'delete'),

                                              HelperFunctions.buildPopupMenu(
                                                  icons: Icons.report, title: 'report', value: 'report'),
                                              HelperFunctions.buildPopupMenu(
                                                  icons: Icons.block, title: 'block', value: 'block'),

                                          // Add more options as needed
                                        ],
                                      ).then((value) {
                                        print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");
                                        if (!HelperFunctions.validateLogin()) {
                                          return;
                                        }
                                        print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");

                                        print("value ===> ${value}");
                                        if (value == 'report') {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                BlocProvider(
                                                  create: (context) => CreateReportCubit(),
                                                  child: ReportDialog(
                                                    reportType: ReportType.chat,
                                                    reportTypeId: conversation.id,
                                                  ),
                                                ),
                                          );
                                        } else if (value == "delete") {
                                          showDialog(
                                            context: context,

                                            builder: (_) =>
                                                AlertDialog(
                                                  content: Text(
                                                    'do_you_want_to_scan'.translate,
                                                    style: const TextStyle(fontSize: 24),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        NavigationService.goBack();
                                                      },
                                                      child: Text(
                                                        'no'.translate,
                                                        style: const TextStyle(color: Colors.black),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await ChatRepo.deleteChatMessage(messageId: conversation.id!,message:false ).then((value) {
                                                          allConversationsCubit.getAllConversations(init: true);


                                                        });
                                                        /*await RemoveVideoRepo.removeVideo(
                                    context, body: {"video_id":"$reportTypeId"});*/
                                                        NavigationService.goBack();

                                                        // print("ggggggggggggg ${reportTypeId}");
                                                        /*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*/
                                                      },
                                                      child: Text(
                                                        'yes'.translate,
                                                        style: const TextStyle(color: Colors.black),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                          );
                                        }
                                        else if(value == "block"){
                                          CustomAwesomeDialog().showOptionsDialog(
                                            context: context,
                                            message: 'block_chat_confirm'.translate,
                                            btnOkText: 'block',
                                            btnCancelText: 'cancel',
                                            onConfirm: () {
                                              submitBlock(blockType: ReportType.chat, blockTypeId: conversation.id!);
                                            },
                                            type: DialogType.warning,
                                          );
                                        }

                                       /* setState(() {
                                          widget.selected =false;
                                        });*/
                                        print("hide\n\n\n\n\n");
                                      });

                                    },
                                    leading: CircleAvatar(
                                      radius: 25.r,
                                      // backgroundColor: Colors.green,
                                      child: CircleAvatar(
                                        backgroundColor: (conversation
                                            .recieverm?.profile ==
                                            null &&
                                            conversation.sender?.profile ==
                                                null)
                                            ? Colors.grey[200]
                                            : Colors.white,
                                        backgroundImage: conversation
                                            .recieverm?.id ==
                                            HelperFunctions.currentUser!.id
                                            ? (HelperFunctions.chatProfileImage(
                                          isGroup: isGroup,
                                          pic: conversation.sender
                                              ?.profile /*??
                                                  conversation.logo*/
                                          ,
                                        ))
                                            : (HelperFunctions.chatProfileImage(
                                          isGroup: isGroup,
                                          pic: conversation.recieverm
                                              ?.profile /*??
                                                  conversation.logo*/
                                          ,
                                        )),
                                        radius: 24.r,
                                        child:
                                        null /* conversation.recieverm?.profile ==null?AssetImage(
                                          'assets/images/${isGroup ? 'new_group_icon.png' : 'person_perview.png'}',
                                          fit: BoxFit.cover,

                                        ):null*/
                                        ,

                                        // child: dummyData[i].online!
                                        //     ? Container(
                                        //         margin: const EdgeInsets.only(
                                        //             bottom: 40, right: 40),
                                        //         width: 20,
                                        //         height: 20,
                                        //         decoration: BoxDecoration(
                                        //           color: Colors.green,
                                        //           shape: BoxShape.circle,
                                        //           border: Border.all(
                                        //             width: 2,
                                        //             color: Colors.white,
                                        //           ),
                                        //         ),
                                        //       )
                                        //     : Container(),
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          userName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          conversation.timeAgo ?? '',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            if (conversation.lmessage?.userId ==
                                                HelperFunctions.currentUser?.id)
                                              Icon(
                                                Icons.done_all,
                                                size: 18,
                                                color: Colors.blue[600],
                                              ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                conversation.lmessage
                                                    ?.description ??
                                                    '_',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            /**
                                                if (!dummyData[i].seen!)
                                                Container(
                                                height: 15,
                                                width: 15,
                                                decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                                ),
                                                child: const Align(
                                                child: Text(
                                                "1",
                                                style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                ),
                                                ),
                                                ),
                                                ),
                                             */
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Divider(
                                    height: 1,
                                    indent: 70,
                                    endIndent: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/*

 CustomAwesomeDialog().showOptionsDialog(
                                        context: context,
                                        message: 'block_chat_confirm'.translate,
                                        btnOkText: 'block',
                                        btnCancelText: 'cancel',
                                        onConfirm: () {
                                          submitBlock(blockType: ReportType.chat, blockTypeId: conversation.id!);
                                        },
                                        type: DialogType.warning,
                                      );
 */
