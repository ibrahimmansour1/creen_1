import 'dart:developer';
import 'dart:io';

import 'package:creen/core/themes/enums.dart';
import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/custom_image.dart';
import 'package:creen/features/chat/components/home_components/components/audio_player_widget.dart';
import 'package:creen/features/chat/viewModel/chat/chat_cubit.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/utils/functions/helper_functions.dart';
import '../../../../../core/utils/widgets/chat_screen.dart';
import '../../../../../core/utils/widgets/report_dialog.dart';
import '../../../../reports/viewModel/createReport/create_report_cubit.dart';
import '../../../model/all_chats_model.dart';

class MessageBox extends StatefulWidget {
  final bool isMe;
  final String? message, record, pdf;
  final String? image;
  final String? userName;
  final String? userProfile;
  final ChatCubit chatCubit;
  final int inde;
   bool selected;
final Message messageElement;
   MessageBox({
    Key? key,
    required this.isMe,
    this.message,
    this.image,
    this.record,
    this.pdf,
    this.userName,
    this.userProfile,
    required this.messageElement,
    required this.inde,
    required this.chatCubit,
    required this.selected,
  }) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    log('link is ${widget.message?.linkFromText}');
    // print("HelperFunctions.currentLanguage ${HelperFunctions.currentLanguage== "ar"}");
    // if (isMe) {
    const radius = Radius.circular(20);
    var crossAxisAlignment =
        widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    return SwipeTo(
      onRightSwipe: () {
        NavigationService.push(
          page: AllConversationsScreen(
            link: widget.message,
          ),
        );
      },
      onLeftSwipe: (){
        /*print("message ${widget.message}");
setState(() {
  widget.chatCubit.messages.removeAt(widget.inde);
});*/
        // print("xxxxxxxx ${}");
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        color: widget.selected?Colors.blue.shade50:null,
        child: InkWell(
          onTap: ()async{
            print("show\n\n\n\n\n");
            setState(() {
              widget.selected =true;
            });

/*
           await Future.delayed(const Duration(seconds: 2), () {

// Here you can write your code




            });
*/


          },
          child: PopupMenuButton(
            child:  Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment:
                widget.isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
                // textDirection:  HelperFunctions.currentLanguage == "ar"?TextDirection.rtl:TextDirection.ltr,
                // textDirection:  HelperFunctions.currentLanguage == "ar"?TextDirection.rtl:TextDirection.ltr,
                children: <Widget>[
                  /*if(!widget.isMe && widget.selected )
                  PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,

                    ),

                    onSelected: (value) {
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
                                  reportType: ReportType.chatMessage,
                                  reportTypeId: widget.messageElement.id,
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
                                    onPressed: () async {
                                      widget.chatCubit.deleteMessage(id: widget.messageElement.id!);                     // var videoData =
                                      *//*await RemoveVideoRepo.removeVideo(
                                    context, body: {"video_id":"$reportTypeId"});*//*
                                      NavigationService.goBack();

                                      // print("ggggggggggggg ${reportTypeId}");
                                      *//*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*//*
                                    },
                                    child: Text(
                                      'yes'.translate,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      NavigationService.goBack();
                                    },
                                    child: Text(
                                      'no'.translate,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      }
                      else if(value == "edit"){
                        print("edit message ${widget.message != null}");
                        if(widget.message != null) {
                          print("widget.message ===> ${widget.message}");
                          widget.chatCubit.sendMessageController.text =  widget.message!;
                          widget.chatCubit.edited = true;
                          widget.chatCubit.messageID = widget.messageElement.id;
                          print("widget.chatCubit.messageID ===> ${widget.chatCubit.messageID}");
                          widget.chatCubit.emit(ChatMessageEdit());
                        }
                      }
                      else if(value == "block"){

                      }

                      setState(() {
                        widget.selected =false;
                      });
                      print("hide\n\n\n\n\n");
                    },
                    position: PopupMenuPosition.under,
                    itemBuilder: (_) =>
                    [
                      if (widget.isMe) ...[
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.edit, title: 'edit', value: 'edit'),
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.delete, title: 'delete', value: 'delete'),
                      ] else
                        ...[
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.report, title: 'report', value: 'report'),
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.block, title: 'block', value: 'block'),
                        ]
                    ],
                  ),
*/
                  // moreChoices(context, id: widget.messageElement.id, mee: widget.isMe),
                  Flexible(
                    child: Container(
                      width: widget.message != null && widget.image == null
                          ? null
                          : widget.record != null
                          ? 230.r
                          : 260.r,

                      decoration: BoxDecoration(
                        color: !widget.isMe
                            ? Colors.white
                            : MainStyle.primaryColor.withOpacity(0.06),
                        borderRadius: BorderRadius.only(
                          bottomLeft: radius,
                          bottomRight: radius,
                          topLeft: ((widget.isMe && HelperFunctions.currentLanguage == "en")|| (!widget.isMe && HelperFunctions.currentLanguage == "ar"))  ? radius : Radius.zero,
                          topRight: ((widget.isMe && HelperFunctions.currentLanguage == "ar")|| (!widget.isMe && HelperFunctions.currentLanguage == "en")) ? radius : Radius.zero,
                          // topRight:  Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: crossAxisAlignment,
                        children: [
                          Visibility(
                            visible: widget.userName != null,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 10.r,
                                right: 10.r,
                                top: 10.r,
                              ),
                              child: Text(
                                widget.userName ?? '',
                                style: TextStyle(
                                    fontSize: 15.r, color: Colors.lightBlue),
                              ),
                            ),
                          ),
                          widget.record != null
                              ? AudioPlayerWidget(
                            isMe: widget.isMe,
                            profile: widget.userProfile ?? '',
                            fileLink: widget.record ?? '',
                            audioDuration: '0:00:00.000012',
                          )
                              : Padding(
                            padding: widget.image != null
                                ? EdgeInsets.zero
                                : const EdgeInsets.all(13.0),
                            child: widget.pdf != null
                                ? InkWell(
                              onTap: () {
                                // launchUrlString(
                                //   pdf!,
                                //   mode: LaunchMode.externalApplication,
                                // );
                                NavigationService.push(
                                  page: PdfViewScreen(pdf: widget.pdf),
                                );
                              },
                              child: BoxHelper(
                                height: 100,
                                width: 240,
                                child: IgnorePointer(
                                  child: PdfViewScreen(
                                    pdf: widget.pdf,
                                    hideAppBar: true,
                                  ),
                                ),
                              ),
                              //  Text(
                              //   '${pdf?.split('/').last}',
                              //   style: TextStyle(
                              //     decoration: TextDecoration.underline,
                              //     fontSize: 15.r,
                              //   ),
                              // ),
                            )
                                : InkWell(
                              onTap: () {
                                var url = widget.message?.linkFromText[0];
                                // log(url, name: 'linkify_url');
                                if ((url ?? "").contains('blog/')) {
                                  NavigationService.push(
                                      page: RoutePaths.blogDetails,
                                      arguments: int.tryParse(
                                          (url ?? "").split('/').last),
                                      isNamed: true);
                                }
                              },
                              child: Column(
                                crossAxisAlignment: widget.isMe
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: widget.image != null,
                                    child: InkWell(
                                      onTap: () {
                                        showImageViewerPager(
                                          context,
                                          MultiImageProvider(
                                            List.generate(
                                              widget.chatCubit
                                                  .chatSentImages.length,
                                                  (index) => Image.network(
                                                  widget.chatCubit
                                                      .chatSentImages[
                                                  index])
                                                  .image,
                                            ),
                                            initialIndex:
                                            widget.chatCubit.imageIndex(
                                              image: widget.image,
                                            ),
                                          ),
                                          swipeDismissible: true,
                                          doubleTapZoomable: true,
                                        );
                                      },
                                      child: CustomImage(
                                        networkImage: widget.image,
                                        responsiveHeight: 150,
                                        responsiveWidth: double.infinity,
                                        verticalPadding: 7,
                                        horizontalPadding: 7,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.message != null &&
                                        widget.message?.isNotEmpty == true,
                                    child: Padding(
                                      padding: widget.image == null
                                          ? EdgeInsets.zero
                                          : EdgeInsets.symmetric(
                                          horizontal: widget.image == null
                                              ? 0
                                              : 10.r,
                                          vertical: 10.r),
                                      child: Column(
                                        crossAxisAlignment:
                                        crossAxisAlignment,
                                        children: [
                                          Visibility(
                                            visible: widget.message!.isLink,
                                            child:
                                            widget.message!.linkFromText
                                                .isEmpty
                                                ? const BoxHelper()
                                                : BoxHelper(
                                              // height: 200,
                                                child:
                                                /// Generate a beautiful link preview card widget
                                                LinkPreviewGenerator(
                                                  bodyMaxLines: 3,
                                                  link: widget.message!.linkFromText[0],
                                                  linkPreviewStyle: LinkPreviewStyle.large,
                                                  showGraphic: true,
                                                )
                                              /*AnyLinkPreview
                                                                          .builder(
                                                                    link: message!
                                                                        .linkFromText
                                                                        .first,
                                                                    itemBuilder:
                                                                        (context,
                                                                            metaData,
                                                                            imageProvider) {
                                                                      log('$imageProvider provider');
                                                                      log('${message!.linkFromText[0]} provider');
                                                                      // print("metaData.desc ${metaData.desc}");
                                                                      return Directionality(
                                                                        textDirection:
                                                                            TextDirection
                                                                                .ltr,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            if (imageProvider !=
                                                                                null) ...[
*//*
                                                                              Image(
                                                                                image:
                                                                                    NetworkImage(message!.linkFromText[0]),
                                                                                height:
                                                                                    80.r,
                                                                                width: double
                                                                                    .infinity,
                                                                                fit: BoxFit
                                                                                    .cover,
                                                                                errorBuilder: (context,
                                                                                        error,
                                                                                        stackTrace) =>
                                                                                    Container(
                                                                                  height:
                                                                                      60.r,
                                                                                  width:
                                                                                      double.infinity,
                                                                                  color:
                                                                                      Colors.white24,
                                                                                  child:
                                                                                      const Icon(
                                                                                    Icons.link,
                                                                                  ),
                                                                                ),
                                                                              ),
*//*
                                                                              Container(
                                                                                width:
                                                                                    double.infinity,
                                                                                height:
                                                                                    60,
                                                                                decoration: BoxDecoration(
                                                                                    image: DecorationImage(
                                                                                  image: NetworkImage(message!.linkFromText[0]),
                                                                                )),
                                                                              ),
                                                                              const BoxHelper(
                                                                                height:
                                                                                    20,
                                                                              ),
                                                                              Text(
                                                                                metaData.title ??
                                                                                    '',
                                                                                style:
                                                                                    const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 15,
                                                                                ),
                                                                              ),
                                                                              const BoxHelper(
                                                                                height:
                                                                                    10,
                                                                              ),
                                                                              Text(
                                                                                metaData.desc ??
                                                                                    '',
                                                                                style:
                                                                                    const TextStyle(color: Colors.grey, fontSize: 12),
                                                                              ),
                                                                            ]
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                    // displayDirection: UIDirection
                                                                    //     .uiDirectionHorizontal,
                                                                    // showMultimedia: false,
                                                                    // bodyMaxLines: 5,
                                                                    // bodyTextOverflow:
                                                                    //     TextOverflow.ellipsis,
                                                                    // titleStyle: const TextStyle(
                                                                    //   color: Colors.black,
                                                                    //   fontWeight:
                                                                    //       FontWeight.bold,
                                                                    //   fontSize: 15,
                                                                    // ),
                                                                    // bodyStyle: const TextStyle(
                                                                    //     color: Colors.grey,
                                                                    //     fontSize: 12),
                                                                  ),*/
                                            ),
                                          ),
                                          Linkify(
                                            locale: localization.locale,
                                            text: widget.message!,
                                            textAlign: RegExp('[ء-ي]')
                                                .hasMatch(
                                                widget.message ?? '')
                                                ? TextAlign.end
                                                : TextAlign.start,
                                            onOpen: (value) {
                                              print("message ${widget.message}");
                                              var url = value.url;
                                              log(url,
                                                  name: 'linkify_url');
                                              if (url.contains('blog/')) {
                                                NavigationService.push(
                                                    page: RoutePaths
                                                        .blogDetails,
                                                    arguments:
                                                    int.tryParse(url
                                                        .split('/')
                                                        .last),
                                                    isNamed: true);
                                              }
                                            },
                                            style: TextStyle(
                                              fontSize: 15.r,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*   if(widget.isMe && widget.selected )
                  PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,

                    ),
                    onSelected: (value) {
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
                                  reportType: ReportType.chatMessage,
                                  reportTypeId: widget.messageElement.id,
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
                                    onPressed: () async {
                                      widget.chatCubit.deleteMessage(id: widget.messageElement.id!);                     // var videoData =
                                      *//*await RemoveVideoRepo.removeVideo(
                                    context, body: {"video_id":"$reportTypeId"});*//*
                                      NavigationService.goBack();

                                      // print("ggggggggggggg ${reportTypeId}");
                                      *//*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*//*
                                    },
                                    child: Text(
                                      'yes'.translate,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      NavigationService.goBack();
                                    },
                                    child: Text(
                                      'no'.translate,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      }
                      else if(value == "edit"){
                        print("edit message ${widget.message != null}");
                        if(widget.message != null) {
                          print("widget.message ===> ${widget.message}");
                          widget.chatCubit.sendMessageController.text =  widget.message!;
                          widget.chatCubit.edited = true;
                          widget.chatCubit.messageID = widget.messageElement.id;
                          print("widget.chatCubit.messageID ===> ${widget.chatCubit.messageID}");
                          widget.chatCubit.emit(ChatMessageEdit());
                        }
                      }
                      else if(value == "block"){

                      }

                      setState(() {
                        widget.selected =false;
                      });
                      print("hide\n\n\n\n\n");


                    },
                    position: PopupMenuPosition.under,
                    itemBuilder: (_) =>
                    [
                      if (widget.isMe) ...[
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.edit, title: 'edit', value: 'edit'),
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.delete, title: 'delete', value: 'delete'),
                      ] else
                        ...[
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.report, title: 'report', value: 'report'),
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.block, title: 'block', value: 'block'),
                        ]
                    ],

                  ),*/
                  // moreChoices(context, id: widget.messageElement.id, mee: widget.isMe),
                ],
              ),
            ),
            // iconSize: MediaQuery.sizeOf(context).width,

            onSelected: (value) {
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
                          reportType: ReportType.chatMessage,
                          reportTypeId: widget.messageElement.id,
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
                            onPressed: () async {
                              widget.chatCubit.deleteMessage(id: widget.messageElement.id!);                     // var videoData =
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
                          TextButton(
                            onPressed: () {
                              NavigationService.goBack();
                            },
                            child: Text(
                              'no'.translate,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                );
              }
              else if(value == "edit"){
                print("edit message ${widget.message != null}");
                if(widget.message != null) {
                  print("widget.message ===> ${widget.message}");
                  widget.chatCubit.sendMessageController.text =  widget.message!;
                  widget.chatCubit.edited = true;
                  widget.chatCubit.messageID = widget.messageElement.id;
                  print("widget.chatCubit.messageID ===> ${widget.chatCubit.messageID}");
                  widget.chatCubit.emit(ChatMessageEdit());
                }
              }
              else if(value == "block"){

              }

              setState(() {
                widget.selected =false;
              });
              print("hide\n\n\n\n\n");
            },
            position: PopupMenuPosition.under,
            itemBuilder: (_) =>
            [
              if (widget.isMe) ...[
                HelperFunctions.buildPopupMenu(
                    icons: Icons.edit, title: 'edit', value: 'edit'),
                HelperFunctions.buildPopupMenu(
                    icons: Icons.delete, title: 'delete', value: 'delete'),
              ] else
                ...[
                  HelperFunctions.buildPopupMenu(
                      icons: Icons.report, title: 'report', value: 'report'),
                  HelperFunctions.buildPopupMenu(
                      icons: Icons.block, title: 'block', value: 'block'),
                ]
            ],
          ),




        ),
      ),
    );
    // } else {
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 10),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Flexible(
    //           child: Container(
    //             decoration: const BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.only(
    //                 bottomRight: Radius.circular(20),
    //                 bottomLeft: Radius.circular(20),
    //                 topRight: Radius.circular(20),
    //               ),
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.all(13.0),
    //               child: Text(
    //                 message!,
    //                 style: const TextStyle(color: Colors.black, fontSize: 14),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // }
  }
  Widget moreChoices(BuildContext context,{required int? id, required bool mee})=>            PopupMenuButton(
    icon: Icon(
      Icons.more_horiz,

    ),
    onSelected: (value) {
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
                  reportType: ReportType.chatMessage,
                  reportTypeId: id,
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
                    onPressed: () async {
                      widget.chatCubit.deleteMessage(id: id!);                     // var videoData =
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
                  TextButton(
                    onPressed: () {
                      NavigationService.goBack();
                    },
                    child: Text(
                      'no'.translate,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
        );
      }
      else if(value == "edit"){
        print("edit message ${widget.message != null}");
        if(widget.message != null) {
          print("widget.message ===> ${widget.message}");
          widget.chatCubit.sendMessageController.text =  widget.message!;
          widget.chatCubit.edited = true;
          widget.chatCubit.messageID = widget.messageElement.id;
          print("widget.chatCubit.messageID ===> ${widget.chatCubit.messageID}");
          widget.chatCubit.emit(ChatMessageEdit());
        }
      }
      else if(value == "block"){

      }


    },
    position: PopupMenuPosition.under,
    itemBuilder: (_) =>
    [
      if (mee) ...[
        HelperFunctions.buildPopupMenu(
            icons: Icons.edit, title: 'edit', value: 'edit'),
        HelperFunctions.buildPopupMenu(
            icons: Icons.delete, title: 'delete', value: 'delete'),
      ] else
        ...[
          HelperFunctions.buildPopupMenu(
              icons: Icons.report, title: 'report', value: 'report'),
          HelperFunctions.buildPopupMenu(
              icons: Icons.block, title: 'block', value: 'block'),
        ]
    ],
  );

}

class PdfViewScreen extends StatefulWidget {
  const PdfViewScreen({super.key, required this.pdf, this.hideAppBar = false});

  final String? pdf;
  final bool hideAppBar;

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  late PdfViewerController pdfViewerController;

  @override
  void initState() {
    pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  void dispose() {
    pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('${widget.pdf}', name: 'pdf_link');

    return Scaffold(
        appBar: widget.hideAppBar
            ? null
            : AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                actions: [
                  IconButton(
                    onPressed: () {
                      Share.share(
                        widget.pdf ?? '',
                      );
                    },
                    color: Colors.white,
                    iconSize: 35.r,
                    icon: const Icon(
                      Icons.share,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // launchUrlString(
                      //   widget.pdf ?? '',
                      //   mode: LaunchMode.externalApplication,
                      // );

                      Directory? downloadsDirectory =
                          await DownloadsPathProvider.downloadsDirectory;
                      if (downloadsDirectory != null) {
                        var filePath =
                            '${downloadsDirectory.path}/${widget.pdf?.split('/').last}';
                        log('path $filePath');
                        File file = File(filePath);

                        var exists = file.existsSync();
                        if (!exists) {
                          file = await file.create(
                            recursive: true,
                          );
                          Dio().download(widget.pdf ?? '', filePath);
                        } else {
                          Fluttertoast.showToast(
                            msg: 'تم تحميل هذا الملف من قبل',
                            backgroundColor: Colors.red,
                          );
                        }
                        // var raf = file.openSync(mode: FileMode.write);
                        log('opened');
                        // log('runtimeType ${exportData.runtimeType}');
                        // response.data is List<int> type
                        // raf.writeFromSync((exportData));
                        // final taskId = await FlutterDownloader.enqueue(
                        //   url: widget.pdf ?? '',
                        //   headers: {}, // optional: header send with url (auth token etc)
                        //   savedDir: filePath,
                        //   // 'the path of directory where you want to save downloaded files',
                        //   // showNotification:
                        //   //     true, // show download progress in status bar (for Android)
                        //   // openFileFromNotification:
                        //   //     true, // click on notification to open downloaded file (for Android)
                        // );
                      }
                    },
                    color: Colors.white,
                    iconSize: 35.r,
                    icon: const Icon(
                      Icons.download,
                    ),
                  ),
                ],
              ),
        body: Container(
          color: Colors.white,
          child: SfPdfViewer.network(
            widget.pdf ?? '',
          ),
        ));
  }

}


