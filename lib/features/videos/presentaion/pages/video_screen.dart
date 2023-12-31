import 'dart:developer';

import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/videos/viewModel/videos/videos_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../widgets/video_play_item.dart';

// final VideoPlayerController videoController = VideoPlayerController.network(
//     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4');
final checkProvider = StateProvider((ref) => true);

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
    this.videoIndex,
  }) : super(key: key);

  /// pass it only from my videos page
  final int? videoIndex;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideosCubit videosCubit;

  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-9259263566568628/5580711691',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // _moveToHome();
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          if (kDebugMode) {
            print('Failed to load an interstitial ad: ${err.message}');
          }
        },
      ),
    );
  }

  //final VideoController videoController = Get.put(VideoController());
  // buildProfile({
  //   String? profilePhoto,
  //   String? name,
  //   String? createdAt,
  //   int? userId,
  // }) {
  //   return InkWell(
  //     onTap: () {
  //       NavigationService.push(
  //           page: MultiBlocProvider(
  //             providers: [
  //               BlocProvider(
  //                 create: (_) => FollowingCubit(
  //                   userId: userId,
  //                 ),
  //               ),
  //               BlocProvider(
  //                 create: (_) => FollowersCubit(
  //                   userId: userId,
  //                 ),
  //               ),
  //               BlocProvider(
  //                 create: (_) => ProfileCubit(
  //                   userId: userId,
  //                 ),
  //               ),
  //             ],
  //             child: const MyProfileScreen(),
  //           ),
  //           isNamed: false);
  //     },
  //     child: Row(
  //       children: [
  //         CircleAvatar(
  //           radius: 23,
  //           backgroundColor: Colors.white,
  //           backgroundImage: profilePhoto == null
  //               ? const AssetImage(
  //                   'assets/images/chef.jpg',
  //                 )
  //               : NetworkImage(profilePhoto) as ImageProvider,
  //         ),
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               name ?? '',
  //               style: MainTheme.authTextStyle.copyWith(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.normal,
  //                   color: Colors.white),
  //             ),
  //             Text(
  //               createdAt ?? '',
  //               style: const TextStyle(color: Colors.white, fontSize: 12),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  void initState() {
    _loadInterstitialAd();
    videosCubit = context.read<VideosCubit>()..getVideos(context);
    if (widget.videoIndex != null) {
      videosCubit.initPageControllerToSpecificPage(
          index: widget.videoIndex!, context: context);
    } else {
      videosCubit.initController(context);
    }
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            if(widget.videoIndex!=null){
              NavigationService.goBack();
              return;
            }
            NavigationService.pushReplacementAll(
                page: RoutePaths.mainPage, isNamed: true);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.r,
          ),
        ),
      ),
      // backgroundColor: Colors.transparent,
      body: BlocBuilder<VideosCubit, VideosState>(
        builder: (context, state) {
          log('emit $state');
          if (state is VideosLoading) {
            return const LoaderWidget();
          }
          if (videosCubit.videos.isEmpty) {
            return Center(
              child: Text(
                'no_videos'.translate,
                style: MainTheme.authTextStyle.copyWith(fontSize: 16),
              ),
            );
          }
          return LoadingOverlay(
            isLoading: state is UploadingVid,
            child: PageView.builder(
              itemCount: videosCubit.videos.length,
              controller: videosCubit.scrollController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var video = videosCubit.videos[index];
                var isLikeVideo = videosCubit.isLikeVideo(index: index);
                var link = HelperFunctions.videoShareLink(videoId: video.id);
                if (index == 0) {
                  log('like=>$isLikeVideo');
                }
                return VideoPlayItem(
                  video: video,
                  videosCubit: videosCubit,
                  isLikeVideo: isLikeVideo,
                  link: link,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
