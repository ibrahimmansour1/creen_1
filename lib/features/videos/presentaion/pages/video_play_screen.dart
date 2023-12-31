import 'package:creen/features/videos/viewModel/videos/videos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../widgets/video_play_item.dart';

class VideoPlayScreen extends StatelessWidget {
  const VideoPlayScreen({
    super.key,
    required this.videoIndex,
  });
  final int videoIndex;

  @override
  Widget build(BuildContext context) {
    var videosCubit = context.read<VideosCubit>();
    var video = videosCubit.videos[videoIndex];
    var isLikeVideo = videosCubit.isLikeVideo(index: videoIndex);
    var link = HelperFunctions.videoShareLink(videoId: video.id);
    return Scaffold(
      body: VideoPlayItem(
        video: video,
        videosCubit: videosCubit,
        isLikeVideo: isLikeVideo,
        link: link,
        index: videoIndex,
      ),
    );
  }
}
