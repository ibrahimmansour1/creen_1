import 'dart:developer';

import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/register_text_field.dart';
import 'package:creen/features/follow/model/user_following_model.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_preview_generator/link_preview_generator.dart';

class LiveChatScreen extends StatefulWidget {
  const LiveChatScreen(
      {super.key,
      required this.user,
      this.liveCreator = true,
      required this.creator});

  final UserFollowers user;
  final UserFollowers creator;
  final bool liveCreator;

  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  TextEditingController messageController = TextEditingController();
String message = 'جميل';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(liveBackgroundImage), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: liveBackground,
          elevation: 0.0,
          leading: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 30.r,
                height: 30.r,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: profile())),
              )
            ],
          ),
          title: Text(
            (widget.liveCreator ? widget.user.name : widget.creator.name)!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemBuilder: (_, index) {
            //TODO: Edit function isMe

            var isMe = true;
            var crossAxisAlignment =
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
            return Visibility(
            visible:
                message != null && message?.isNotEmpty == true,
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Visibility(
                  visible: message!.isLink,
                  child: message!.linkFromText.isEmpty
                      ? const BoxHelper()
                      : BoxHelper(
                          // height: 200,
                          child:

                              /// Generate a beautiful link preview card widget
                              LinkPreviewGenerator(
                          bodyMaxLines: 3,
                          link: message!.linkFromText[0],
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
*/ /*
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
*/ /*
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
                  text: message!,
                  textAlign: RegExp('[ء-ي]').hasMatch(message ?? '')
                      ? TextAlign.end
                      : TextAlign.start,
                  onOpen: (value) {
                    // print("message ${message}");
                    var url = value.url;
                    log(url, name: 'linkify_url');
                    if (url.contains('blog/')) {
                      NavigationService.push(
                          page: RoutePaths.blogDetails,
                          arguments: int.tryParse(url.split('/').last),
                          isNamed: true);
                    }
                  },
                  style: TextStyle(
                    fontSize: 15.r,
                  ),
                ),
              ],
            ),
          );
          },
        itemCount: 20,),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            InkWell(
              onTap: () {
                //TODO: create send function
                //TODO:  implement send function
              },
              child: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.r, left: 20, right: 10),
              child: RegisterTextField(
                maxLines: null,
                controller: messageController,
                isStatus: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider<Object> profile() {
    if (widget.user?.profile != null && widget.liveCreator) {
      return NetworkImage(widget.user!.profile!);
    } else if (!widget.liveCreator && widget.creator.profile != null) {
      return NetworkImage(widget.creator.profile!);
    } else {
      return const AssetImage(personProfile);
    }
  }
}
