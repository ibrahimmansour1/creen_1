import 'dart:developer';

import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/widgets/mirror_widget.dart';
// import 'package:audioplayer/audioplayer.dart';pp

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({
    Key? key,
    required this.isMe,
    required this.fileLink,
    required this.audioDuration,
    required this.profile,
  }) : super(key: key);
  final bool isMe;
  final String fileLink;
  final String audioDuration;
  final String profile;

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  Duration? position;
  Duration? duration;
  Duration? webDuration;
  AudioPlayer player = AudioPlayer();
  // int startDuration = 0;
  // int durations = 6;
  // Duration _duration = Duration(seconds: 0);
  // bool isPlaying = false;
  // AudioPlayerStat playerState = AudioPlayerState.STOPPED;

  get isPlaying => player.playing;
  // get isPaused => playerState == AudioPlayerState.PAUSED;

  // String get durationText =>
  //     duration == null ? '' : duration.toString().split('.').first;
  // String get positionText =>
  //     position == null ? '' : position.toString().split('.').first;
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    log('here is my duration b:: ${widget.audioDuration}');
    if (widget.audioDuration.isNotEmpty) {
      var durationFromString = widget.audioDuration.split(':');
      webDuration = Duration(
        hours: int.parse(durationFromString[0]),
        minutes: int.parse(
          durationFromString[1],
        ),
        seconds: int.parse(durationFromString[2].split('.')[0]),
        microseconds: int.parse(durationFromString[2].split('.')[1]),
      );
    }
    // AudioPlayer()
    // player.setUrl(widget.fileLink);

    player.currentIndexStream.listen((event) {
      log('index $event');
    });
    player.playerStateStream.listen((event) {
      // print('playStream: $event');
      if (event.processingState == ProcessingState.completed) {
        player.stop();
        log('index $event');
        setState(() {
          position = const Duration(seconds: 0);
        });
      }
    });
    player.durationStream.listen((event) {
      log('here is your dummy ${event ?? widget.audioDuration}');
      log('here is your dummy ${event == null}');
      // print('here is your dummy ${event ?? widget.audioDuration}');
      // print('here is your dummy ${event} event');
      // print('here is your dummy ${event == null}');
      if (player.playing) {
        setState(() {
          duration = player.duration ?? webDuration;
        });
        // print('webDuration ${widget.audioDuration}');
      }
      // print('duration ${event ?? widget.audioDuration}');
    });
    player.positionStream.listen((event) {
      if (player.playing) {
        setState(() {
          position = event;
        });
        log('podition fork $position duration $duration');
        // print('podition fork $position duration $duration');
      } else {
        setState(() {
          position = const Duration(seconds: 0);
        });
      }

      log('position: $event');
      // print('position: $event');
    });
    player.playingStream.listen((event) {
      if (duration != null && position != null) {
        log('po ${position?.inSeconds} du ${duration?.inSeconds}');
      }
      if (event) {
        // print('playng${player.duration ?? webDuration}');

        setState(() {
          duration = player.duration ?? webDuration;
        });
      } else {
        // print('stops${player.duration ?? webDuration}');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var myConversationProvider = context.read(myConversationsProvider);
    return Consumer(
      builder: (_, watch, __) {
        // var conv = watch(myConversationsProvider);
        // var myFile = conv.getMyCurrentFile(widget.fileLink);

        // if (myFile != null) {
        //   if (!myFile.isPlaying && player.playing) {
        //     player.stop();
        //   }
        // }
        var children = [
          // Player.network(fileLink);
          // Kplayer
          InkWell(
            onTap: () async {
              if (isPlaying) {
                log('playng');
                player.pause();
              } else {
                // pti
                // myConversationProvider.changePlayStatus(widget.fileLink);

                log('paused ${player.playerState}');
                if (player.processingState == ProcessingState.ready) {
                  log('ggg');
                } else {
                  await player.setUrl(widget.fileLink);
                }

                player.play().then((value) {
                  log('myDuration is ${player.duration} %&& position is $position && audioDuration is ${duration?.inSeconds}');
                }).onError((error, stackTrace) {
                  log('myDuration is ${player.duration} %&& position is $position && audioDuration is ${duration?.inSeconds}');
                });
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: widget.profile.isEmpty
                        ? const AssetImage(
                            'assets/images/product.jpg',
                          )
                        : NetworkImage(
                            widget.profile,
                          ) as ImageProvider,
                    fit: BoxFit.cover),
              ),
              height: 40.r,
              width: 40.r,
            ),
            // Icon(
            //   isPlaying ? Icons.pause : Icons.play_arrow,
            //   color: widget.isMe
            //       ? Colors.white
            //       : Theme.of(context).primaryColor,
            // ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: widget.isMe
                    ? Colors.white24
                    : Theme.of(context).primaryColor,
              ),
              child: MirrorWidget(
                mirror: widget.isMe,
                child: Slider.adaptive(
                  activeColor: widget.isMe
                      ? Colors.white
                      : Theme.of(context).primaryColor,

                  min: 0.0,
                  max: duration == null
                      ? 5
                      : duration?.inMilliseconds.toDouble() == 0
                          ? 12
                          : (duration?.inMilliseconds.toDouble() ?? 0.0) + 0.9,
                  value: position?.inMilliseconds.toDouble() ?? 0.0,
                  onChanged: (v) {},
                  //  (double value) {
                  //   setState(() {
                  //     startDuration = value.toInt();
                  //   });
                  //  return player
                  //       .seek((Duration(seconds: value.toInt())));
                  // },
                ),
              ),
            ),
          ),
        ];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            textDirection: widget.isMe ? TextDirection.rtl : TextDirection.ltr,
            // children: widget.isMe ? children2.reversed.toList() : children2,
            children: children,
          ),
        );
      },
    );
  }
}
