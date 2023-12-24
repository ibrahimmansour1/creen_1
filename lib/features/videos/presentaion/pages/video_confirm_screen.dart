import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/register_text_field.dart';

class VideoConfirmScreen extends StatefulWidget {
  const VideoConfirmScreen({
    Key? key,
    required this.pickedVid,
  }) : super(key: key);
  final File pickedVid;

  @override
  State<VideoConfirmScreen> createState() => _VideoConfirmScreenState();
}

class _VideoConfirmScreenState extends State<VideoConfirmScreen> {
  late FlickManager flickManager;
  late VideoPlayerController videoPlayerController;
  var descriptionController = TextEditingController();
  @override
  void dispose() {
    flickManager.dispose();
    // videoPlayerController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(
      widget.pickedVid,
      videoPlayerOptions: VideoPlayerOptions(),
    );
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController,
      onVideoEnd: () {
        videoPlayerController.play();
      },
    );
    videoPlayerController.addListener(_listeners);
  }

  void _listeners() {
    if (videoPlayerController.value.isPlaying) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            InkWell(
                onTap: () {
                  NavigationService.goBack();
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.r, horizontal: 5.r),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white38,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                )),
          ]),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BoxHelper(
                child: FlickVideoPlayer(
              flickManager: flickManager,
            )),
          ),
          const BoxHelper(
            height: 7,
          ),
          Row(
            textDirection: TextDirection.ltr,
            children: [
              InkWell(
                onTap: () {
                  NavigationService.goBack(result: descriptionController.text);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.r),
                  child: RegisterTextField(
                    maxLines: null,
                    controller: descriptionController,
                  ),
                ),
              ),
              const BoxHelper(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
