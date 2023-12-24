import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/custom_image.dart';
import 'package:creen/features/chat/components/chat_components/components/message_box.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../viewModel/chat/chat_cubit.dart';

class BottomSendNavigation extends StatefulWidget {
  const BottomSendNavigation({Key? key}) : super(key: key);

  @override
  _BottomSendNavigationState createState() => _BottomSendNavigationState();
}

class _BottomSendNavigationState extends State<BottomSendNavigation>
    with SingleTickerProviderStateMixin {
   late ChatCubit chatCubit ;
  bool chatSelected = false;
  bool showEmoji = false;


  Icon _emojiIcon = const Icon(
    FontAwesomeIcons.faceSmileWink,
    color: Colors.grey,
    size: 20,
  );

  @override
  void initState() {
    super.initState();
    chatCubit = context.read<ChatCubit>();

    chatCubit.focusNode.addListener(
      () {
        if (chatCubit.focusNode.hasFocus) {
          setState(() {
            showEmoji = false;
            _emojiIcon = const Icon(
              FontAwesomeIcons.keyboard,
              color: Colors.grey,
              size: 20,
            );
          });
        } else {
          setState(() {
            showEmoji = true;
            _emojiIcon = const Icon(
              FontAwesomeIcons.faceSmileWink,
              color: Colors.grey,
              size: 20,
            );
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {


        print("chatCubit.messages.length    =======> ${chatCubit.messages.length}\n\n\n\n\n");
        return WillPopScope(
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            child: Column(
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: HelperFunctions.currentLanguage == 'ar'
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    child: ListView(
                      reverse: true,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      children: List.generate(
                        chatCubit.messages.length,
                        (index) {
                          var message = chatCubit.messages[index];
                          var isMe =
                              message.userId == HelperFunctions.currentUser?.id;
                          var record = message.record;
                          var pdf = message.pdf;
                          chatCubit.selected = List.generate(chatCubit.messages.length, (index) => false);
                          chatSelected = chatCubit.selected[index];
                          log('${chatCubit.user?.name} ${chatCubit.recieverm?.name}',
                              name: 'users_data');
                          return MessageBox(
                            chatCubit: chatCubit,
                            isMe: isMe,
                            image: message.image,
                            message: message.description ?? '',
                            pdf: pdf,
                            record: record,
                            userName: chatCubit.isGroup && !isMe
                                ? message.userName
                                : null,
                            userProfile: isMe
                                ? chatCubit.user?.profile ?? ''
                                : chatCubit.recieverm?.profile ?? '',
                            inde: index, messageElement: message, selected: chatSelected,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: chatCubit.pickedFile != null,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomImage(
                          pickedImage: chatCubit.pickedFile,
                          onRemoved: () => chatCubit.removePickedImage(),
                        ),
                      ),
                    ),
                    SizedBox(
                      // height: 60,dsdsd
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.289,
                                  // height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                      // bottomLeft: Radius.circular(20),
                                    ),
                                    // borderRadius: const BorderRadius.only(
                                    //   topLeft: Radius.circular(20),
                                    //   bottomLeft: Radius.circular(20),
                                    // ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: _emojiIcon,
                                          onPressed: () {
                                            chatCubit.focusNode.unfocus();
                                            chatCubit.focusNode.canRequestFocus = false;
                                            setState(() {
                                              showEmoji = !showEmoji;
                                              _emojiIcon = const Icon(
                                                  FontAwesomeIcons.keyboard);
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Container(
                                            // decoration: BoxDecoration(

                                            // ),
                                            constraints: BoxConstraints(
                                              maxHeight: 130.r,
                                            ),
                                            child: TextField(
                                              textDirection: HelperFunctions
                                                          .currentLanguage ==
                                                      'ar'
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                              maxLines: null,
                                              focusNode: chatCubit.focusNode,
                                              cursorColor: Colors.black,
                                              controller: chatCubit
                                                  .sendMessageController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Type Here",
                                                // prefixIcon:
                                                // suffixIcon:
                                              ),
                                            ),
                                          ),
                                        ),
                                        PopupMenuButton(
                                          itemBuilder: (context) => [
                                            HelperFunctions.buildPopupMenu(
                                                icons: Icons.picture_as_pdf,
                                                title: 'Pdf',
                                                value: 'pdf'),
                                            HelperFunctions.buildPopupMenu(
                                              icons: Icons.image_outlined,
                                              title: 'Gallery',
                                              value: 'gallery',
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == 'gallery') {
                                              chatCubit.pickFile(
                                                context: context,
                                              );
                                            } else if (value == 'pdf') {
                                              chatCubit.pickPdfFile(
                                                context: context,
                                              );
                                            }
                                          },
                                          child: const IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              FontAwesomeIcons.paperclip,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Container(
                                //   padding: const EdgeInsets.only(right: 12),
                                //   // height: 40,
                                //   decoration: BoxDecoration(
                                //     color: Colors.grey.shade200,
                                //     borderRadius: const BorderRadius.only(
                                //       bottomRight: Radius.circular(20),
                                //       topRight: Radius.circular(20),
                                //     ),
                                //   ),
                                //   child: Listener(
                                //     onPointerMove: chatCubit.cancelRecording,
                                //     child: LongPressDraggable(
                                //       axis: Axis.horizontal,
                                //       feedback: FloatingActionButton(
                                //         onPressed: () {},
                                //         backgroundColor:
                                //             Theme.of(context).primaryColor,
                                //         child: Icon(
                                //           Icons.keyboard_voice_outlined,
                                //           // color: Styles.iconThemeData.color,
                                //         ),
                                //       ),
                                //       childWhenDragging: const BoxHelper(),
                                //       onDragStarted: chatCubit.startRecorder,
                                //       onDragEnd: chatCubit.endRecorder,
                                //       child: IconButton(
                                //         onPressed: null,
                                //         // chatCubit.checkForPermission,
                                //         icon: Icon(
                                //           Icons.keyboard_voice_outlined,
                                //           // color: Styles.iconThemeData.color,
                                //         ),
                                //       ),
                                //     ),
                                //   ),

                                //   //  const Icon(
                                //   //   FontAwesomeIcons.microphone,
                                //   //   color: Colors.grey,
                                //   //   size: 20,
                                //   // ),
                                // ),
                                const BoxHelper(width: 7),
                                AnimatedCrossFade(
                                  firstChild: RecordIcon(chatCubit: chatCubit),
                                  secondChild: SendIcon(chatCubit: chatCubit),
                                  firstCurve: Curves.easeInOut,
                                  secondCurve: Curves.easeInOut,
                                  crossFadeState: chatCubit.canRecord
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(
                                    milliseconds: 600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //showEmoji ? showEmojiPicker() : Container(),
                  ],
                ),
              ],
            ),
          ),
          onWillPop: () {
            if (showEmoji) {
              setState(() {
                showEmoji = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        );
      },
    );
  }

// Widget showEmojiPicker() {
//   return EmojiPicker(
//     rows: 4,
//     columns: 7,
//     onEmojiSelected: (emoji, category) {
//       _sendMessageController.text = _sendMessageController.text + emoji.emoji;
//     },
//   );
// }
}

class SendIcon extends StatelessWidget {
  const SendIcon({
    Key? key,
    required this.chatCubit,
  }) : super(key: key);

  final ChatCubit chatCubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        chatCubit.senMessage();
      },
      child: Container(
        padding: const EdgeInsets.only(right: 5),
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: MainStyle.primaryColor,
        ),
        child: const Icon(
          FontAwesomeIcons.solidPaperPlane,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class RecordIcon extends StatefulWidget {
  RecordIcon({
    Key? key,
    required this.chatCubit,
  }) : super(key: key);

  final ChatCubit chatCubit;

  @override
  State<RecordIcon> createState() => _RecordIconState();
}

class _RecordIconState extends State<RecordIcon> {
  bool pause = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: widget.chatCubit.cancelRecording,
      child: LongPressDraggable(
        axis: Axis.vertical,
        feedback: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 37.r,
            // width: 37.r,
            child: Row(
              textDirection: HelperFunctions.reversedDirection,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      builder: (BuildContext context) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Icon(Icons.delete),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  pause = !pause;
                                });
                              },
                              child:
                                  Icon(pause ? Icons.play_arrow : Icons.pause),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(Icons.send),
                            ),
                          ],
                        );
                      },
                      context: context,
                    );
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(
                    Icons.keyboard_voice_outlined,

                    // color: Styles.iconThemeData.color,
                  ),
                ),
                const BoxHelper(
                  width: 10,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'اسحب للإلغاء',
                      speed: const Duration(milliseconds: 500),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.r,
                      ),
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.white,
                        Colors.white,
                        Colors.black,
                        Colors.black,
                        Colors.black,
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                  ],
                  totalRepeatCount: 10,
                ),
              ],
            ),
          ),
        ),
        childWhenDragging: const BoxHelper(),
        onDragStarted: widget.chatCubit.startRecorder,
        onDragEnd: widget.chatCubit.endRecorder,
        child: Container(
          // padding:
          //     const EdgeInsets.only(right: 5),
          height: 37.r,
          width: 37.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: MainStyle.primaryColor,
          ),
          child: const Icon(
            Icons.keyboard_voice_outlined,
            color: Colors.white,
            // color: Styles.iconThemeData.color,
          ),
        ),
      ),
    );
  }
}
