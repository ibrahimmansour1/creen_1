import 'dart:developer';
// import 'dart:js_interop';

import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/chat/repo/update_story_seen_repo.dart';
import 'package:creen/features/follow/viewModel/follow/follow_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:story/story_page_view.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/utils/responsive/sizes.dart';
import '../../../../../core/utils/routing/navigation_service.dart';
import '../../../../../core/utils/widgets/banner_ad_widget.dart';
import '../../../../../core/utils/widgets/follow_button.dart';
import '../../../viewModel/stories/stories_cubit.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen({
    super.key,
    // required this.storyPublisher,
    required this.initStoryPage,
  });

  // final List<StoryPublisher> storyPublisher;
  final int initStoryPage;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen> {
  ValueNotifier<IndicatorAnimationCommand>? indicatorAnimationController;
  late StoriesCubit storiesCubit;
int storyDuration = 7;
  // ValueNotifier<IndicatorAnimationCommand>();
  int _pageIndex = 0;
  int _storyIndex = 0;
  VideoPlayerController? videoController;
  Future<void>? _initializeVideoPlayerFuture;

  // late final Size video;
  String? videoUrl;

  void _playVideo(String videoUr) {
    videoUrl = videoUr;
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoUr));
    _initializeVideoPlayerFuture = videoController!.initialize();
    // video = videoController!.value.size;
    // Use the controller to loop the video.
    videoController!.setLooping(false);
    videoController!.play();
  }

  void _stopVideo() {
    videoController!.dispose();
    videoUrl = null;
  }

  @override
  void initState() {
    storiesCubit = context.read<StoriesCubit>();
    indicatorAnimationController?.dispose();
storyDuration = storiesCubit.stories[0].story?[0].video !=null ? 30 :7;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return Scaffold(
      body: BlocBuilder<StoriesCubit, StoriesState>(
        builder: (context, state) {
          log('gggggggggggggg');
          return StoryPageView(
            // engl: false,
            itemBuilder: (context, pageIndex, storyIndex) {
              final user = storiesCubit.stories[pageIndex];
              _pageIndex = pageIndex;
              final story = user.story?[storyIndex];
              UpdateStorySeenRepo.updateSeen(storyId: story!.id!);
              log('font size ${story?.fontSize}');
              bool isNotText = (story?.image != null ||
                  story?.video != null ||
                  story?.record != null);
              _pageIndex = pageIndex;
              _storyIndex = storyIndex;
// log('story color ${story?.background}');
              if (story!.video != null) {
                _playVideo(story.video);
              }
           return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                        color: isNotText
                            ? Colors.black
                            : Color(int.parse(story?.background ?? "0"))),
                  ),
                  if (story?.image != null)
                    Positioned.fill(
                      child: Image.network(
                        story?.image,
                        // fit: BoxFit.cover,
                      ),
                    ),
                  if (story?.video != null)
                    Positioned.fill(
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If the VideoPlayerController has finished initialization, use
                            // the data it provides to limit the aspect ratio of the video.
                            return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.8,
                              child: AspectRatio(
                                aspectRatio: videoController!.value.aspectRatio,
                                // Use the VideoPlayer widget to display the video.
                                child: VideoPlayer(videoController!),
                              ),
                            );
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  if (story?.description != null && story?.image == null)
                    Center(
                      child: SizedBox(
                        // alignment: Alignment.center,
                        width: MediaQuery.sizeOf(context).width,
                        // color: Colors.red,
                        child: Text(
                          story?.description ?? '',
                          textAlign: isNotText?TextAlign.center:TextAlign.values[int.parse(story?.align??'2')],
                          // TextAlign.center,
                          style: TextStyle(
                              color: isNotText
                                  ? Colors.white
                                  : Color(int.parse(story?.fontColor ?? "0")),
                              fontSize: isNotText
                                  ? null
                                  : (double.parse(story?.fontSize ?? '18.0')),
                              fontFamily: story?.fontFamily,
                              fontStyle: isNotText?null:(story?.outline == '0'?FontStyle.normal:FontStyle.italic),
                            fontWeight: isNotText?null:FontWeight.values[int.parse(story?.fontWeight??'3')]  ,
                            inherit: true,
                            shadows: (isNotText && story?.fontBorderColor != null)?null:[
                              Shadow(
                                // bottomLeft
                                  offset: const Offset(-1.5, -1.5),
                                  color: Color(int.parse(story?.fontBorderColor ?? "0")
              )),
                              Shadow(
                                // bottomRight
                                  offset: const Offset(1.5, -1.5),
                                color: Color(int.parse(story?.fontBorderColor ?? "0")
              )),
                              Shadow(
                                // topRight
                                  offset: const Offset(1.5, 1.5),
                                color: Color(int.parse(story?.fontBorderColor ?? "0"))
              ),
                              Shadow(
                                // topLeft
                                  offset: const Offset(-1.5, 1.5),
                                  color: Color(int.parse(story?.fontBorderColor ?? "0"))
                              ),
                            ],
                            // color: (story?.description != null && story?.)?Colors.white:Color(int.parse(story?.background??"0")),
                              // color: Color(int.parse('ff'+'ff3455',radix: 16)),
                              // fontSize: ,
                              ),
                        ),
                      ),
                    )
                  else ...[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Visibility(
                            visible: story?.description != null &&
                                story?.image != null,
                            child: Container(
                              // padding: EdgeInsets.symmetric(vertical: 3.r),
                              color: Colors.black38,
                              width: Sizes.screenWidth(),
                              margin: EdgeInsets.only(
                                  bottom: Sizes.screenWidth() * 0.09),
//font_border_color
                              child: Text(
                                story?.description ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.r,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: storyIndex == 0,
                              child: BannerAdWidget(
                                adSize: AdSize.fullBanner,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.visibility,
                                color: Colors.white,
                              ),
                              const BoxHelper(
                                width: 5,
                              ),
                              Text(
                                '${story?.seen ?? 0}',
                                style: MainTheme.appBarTextStyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      padding: const EdgeInsets.only(top: 44, left: 8),
                      child: Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: user.profile == null ?const AssetImage(personProfile):NetworkImage(user.profile !)as ImageProvider<Object>,
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: Sizes.screenWidth() * 0.3,
                            child: Text(
                              user.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 17.r,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              );
            },
            gestureItemBuilder: (context, pageIndex, storyIndex) {
              var user = storiesCubit.stories[pageIndex];
              return Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Row(
                    // crossAxisAlignment: Cro,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (user.id != HelperFunctions.currentUser?.id) ...[
                        IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          icon: const SizedBox(
                              height: 25,
                              width: 25,
                              child: Image(
                                image: AssetImage('assets/images/share.png'),
                                color: Colors.white,
                              )),
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          icon: const Icon(
                            Icons.thumb_up_alt,
                            size: 27,
                          ),
                          onPressed: () {},
                        ),
                        BlocBuilder<FollowCubit, FollowState>(
                          builder: (context, state) {
                            if (state is FollowLoading) {
                              return const LoaderWidget(
                                color: Colors.white,
                              );
                            }
                            return FollowButton(
                              isFollow: user.isFollow!,
                              onPressed: () {
                                context.read<FollowCubit>().follow(
                                      context,
                                      userId: user.id,
                                      isFollow: user.isFollow!,
                                    );
                              },
                            );
                          },
                        ),
                        const BoxHelper(
                          width: 15,
                        ),
                      ],
                      Visibility(
                        visible: storiesCubit.stories[pageIndex].id ==
                            HelperFunctions.currentUser?.id,
                        child: PopupMenuButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          // icon: const Icon(Icons.close),
                          position: PopupMenuPosition.under,
                          onSelected: (value) {
                            if (value == 'delete') {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: Text(
                                    'do_you_want_to_scan'.translate,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        NavigationService.goBack();
                                        storiesCubit
                                            .deleteStoryByIndex(
                                                storyIndex: storyIndex,
                                                pageIndex: pageIndex,
                                                userId: storiesCubit
                                                        .stories[pageIndex]
                                                        .id ??
                                                    0,
                                                context: context)
                                            .then((value) =>
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "The status is deleted"));
                                      },
                                      child: Text(
                                        'yes'.translate,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        NavigationService.goBack();
                                      },
                                      child: Text(
                                        'no'.translate,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            HelperFunctions.buildPopupMenu(
                              icons: Icons.delete,
                              title: 'delete',
                              value: 'delete',
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            pageLength: storiesCubit.stories.length,
            initialStoryIndex: (ind){
              log('indindindindindind ${ind}');
              return 0;
            },
            indicatorDuration: Duration(
                seconds: storyDuration),
            initialPage: widget.initStoryPage,
            storyLength: (int pageIndex) {
              log('video or image ===> ${videoUrl ==
                  null
                  ? 7
                  : 30}');
              log('page Index ${pageIndex}');
              // storiesCubit.stories[pageIndex].story?.length ?? 0
             /* if(pageIndex < (storiesCubit.stories[pageIndex].story!.length-1)) {
                setState(() {
                  storyDuration = storiesCubit.stories[pageIndex].story?[0]!.video != null?30:7;
                });
                log('story length ${storiesCubit.stories[pageIndex].story?.length ?? 0}');
              }*/
              if (videoUrl != null) {
                _stopVideo();
                videoUrl = null;
              }

              return storiesCubit.stories[pageIndex].story?.length ?? 0;
            },
            onPageLimitReached: () {

              if (videoUrl != null) {
                _stopVideo();
                videoUrl = null;
              }
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
