import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../../../../core/utils/functions/helper_functions.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final double wid;
  final double hei;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
     this.wid=1.0,
     this.hei=1.0,
  }) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  late FlickManager flickManager;
  bool isMute = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
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
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: size.width*widget.wid,
          height: size.height*widget.hei,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: InkWell(
              child: FlickVideoPlayer(
            flickManager: flickManager,
            flickVideoWithControls: FlickVideoWithControls(
              controls: FlickPortraitControls(
                iconSize: 0,
                fontSize: 0,
                progressBarSettings: FlickProgressBarSettings(
                  padding: EdgeInsets.only(bottom: 55.r),
                ),
              ),
            ),
          )
          ),
        ),
        Positioned(
          top: ScreenUtil().screenHeight * 0.33,
          right: HelperFunctions.isArabic ? 80.r : 10,
          left: !HelperFunctions.isArabic ? 80.r : -205.r,
          child: StatefulBuilder(builder: (context, setState) {
            return InkWell(
              onTap: () {
                log('message');
                setState(() {
                  isMute = !isMute;
                });
                videoPlayerController.setVolume(isMute ? 0 : 1);
              },
              child: Icon(
                isMute ? Icons.volume_off : Icons.volume_up,
                color: Colors.white,
                size: 30.r,
              ),
            );
          }),
        ),
      ],
    );
  }
}
