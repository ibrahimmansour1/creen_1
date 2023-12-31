import 'dart:developer';

import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeWidget extends StatefulWidget {
  const YoutubeWidget({
    Key? key,
    required this.youtubeLink,
    required this.isFirstItem,
  }) : super(key: key);
  final String youtubeLink;
  final bool isFirstItem;

  @override
  State<YoutubeWidget> createState() => _YoutubeWidgetState();
}

class _YoutubeWidgetState extends State<YoutubeWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeLink.split('/').last,
      flags: YoutubePlayerFlags(
        autoPlay: widget.isFirstItem,
        mute: false,
      ),
    );
    _controller.addListener(_onPlaying);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.youtubeLink),
      onVisibilityChanged: (info) {
        var percent = info.visibleFraction * 100;
        // log('visibility ${percent}');
        var isHide = percent < 50 && percent >= 0;
        // log('isHide $isHide');
        if (isHide) {
          _controller.pause();
        }
        if (percent > 60) {
          _controller.play();
        }
      },
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        // videoProgressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
          ),
          RemainingDuration(),
          const PlaybackSpeedButton(),
        ],
        onReady: () {
          // _controller.addListener(listener);
        },
      ),
    );
  }

  void _onPlaying() async {
    var isEnabled = await Wakelock.enabled;
    if (_controller.value.isPlaying && !isEnabled) {
      log(
        'playing',
        name: 'playing_status',
      );
      Wakelock.enable();
    } else if (!_controller.value.isPlaying && isEnabled) {
      log(
        'not playing',
        name: 'playing_status',
      );

      Wakelock.disable();
    }
  }
}
