import 'package:creen/core/utils/constants.dart';
import 'package:creen/features/videos/presentaion/widgets/video_player_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/themes/themes.dart';
import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/widgets/banner_ad_widget.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/chat_screen.dart';
import '../../../../core/utils/widgets/comments_list_widget.dart';
import '../../../../core/utils/widgets/customized_read_more.dart';
import '../../../../core/utils/widgets/follow_button.dart';
import '../../../../core/utils/widgets/mirror_widget.dart';
import '../../../../core/utils/widgets/report_and_block_menu.dart';
import '../../../follow/viewModel/followers/followers_cubit.dart';
import '../../../follow/viewModel/following/following_cubit.dart';
import '../../../profile/presentaion/pages/my_profile.dart';
import '../../../profile/viewModel/profile/profile_cubit.dart';
import '../../model/videos_model.dart';
import '../../viewModel/videos/videos_cubit.dart';

class VideoPlayItem extends StatelessWidget {
  const VideoPlayItem({
    super.key,
    required this.video,
    required this.videosCubit,
    required this.isLikeVideo,
    required this.link,
    required this.index,
  });

  final VideoData video;
  final VideosCubit videosCubit;
  final bool isLikeVideo;
  final String link;
  final int index;
  @override
  Widget build(BuildContext context) {
    // print("video ${video.url}");
    return Stack(
      fit: StackFit.loose,
      children: [
        VideoPlayerItem(
          videoUrl: video.url ?? '',
        ),
        Visibility(visible: index%3==0, child:  BannerAdWidget(adSize: AdSize.fullBanner,)),

        Positioned(
          bottom: Sizes.screenHeight() * 0.13,
          right: !HelperFunctions.isArabic ? 80.r : 10,
          left: HelperFunctions.isArabic ? 80.r : 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.black,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 5.r),
                child: CustomizedReadMore(
                  data: video.description,
                  maxLines: 2,
                  txtColor: Colors.white,
                ),
              ),
              const BoxHelper(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const BoxHelper(
                        width: 5,
                      ),
                      // buildProfile(
                      //   profilePhoto: video.user?.profile,
                      //   name: video.user?.name,
                      //   createdAt: video.timeAgo,
                      //   userId: video.userId,
                      // ),
                      InkWell(
                        onTap: () {
                          NavigationService.push(
                              page: MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (_) => FollowingCubit(
                                      userId: video.userId,
                                    ),
                                  ),
                                  BlocProvider(
                                    create: (_) => FollowersCubit(
                                      userId: video.userId,
                                    ),
                                  ),
                                  BlocProvider(
                                    create: (_) => ProfileCubit(
                                      userId: video.userId,
                                    ),
                                  ),
                                ],
                                child: const MyProfileScreen(),
                              ),
                              isNamed: false);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.white,
                              backgroundImage: video.user?.profile == null
                                  ? const AssetImage(
                                     personProfile,
                                    )
                                  : NetworkImage(video.user?.profile)
                                      as ImageProvider,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  video.user?.name ?? '',
                                  style: MainTheme.authTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                                Text(
                                  video.timeAgo ?? '',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible:
                        HelperFunctions.currentUser?.id != video.user?.id &&
                            video.user?.isFollow == false,
                    child: FollowButton(
                      isFollow: video.user?.isFollow ?? false,
                      onPressed: () {},
                    ),
                  ),
                  // SizedBox(
                  //   width: Sizes.screenWidth() * 0.3,
                  // ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //       width: 2,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  //   child: FloatingActionButton(
                  //     mini: true,
                  //     backgroundColor: Colors.transparent,
                  //     onPressed: () {
                  //       NavigationService.push(
                  //           page: const AddVideoScreen(), isNamed: false);
                  //     },
                  //     child: const Center(
                  //       child: Icon(
                  //         Icons.add,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: Sizes.screenHeight() * 0.19,
          left: HelperFunctions.isArabic?Sizes.screenWidth() * 0.05:null,
          right: !HelperFunctions.isArabic?Sizes.screenWidth() * 0.05:null,
          child: Column(
            children: [
              // InkWell(
              //   onTap: () {
              //     // ref.read(checkProvider.state).state =
              //     //     !ref.read(checkProvider.state).state;
              //   },
              //   //     videoController.likeVideo(data.id),
              //   child: CircleAvatar(
              //       radius: 25,
              //       // backgroundColor: Colors.white,
              //       child: Text(
              //         true ? 'متابعة' : 'متابع',
              //         style: MainTheme.authTextStyle.copyWith(
              //           color: true ? Colors.white : Colors.red,
              //           fontSize: 12,
              //           fontWeight: FontWeight.normal,
              //         ),
              //       )),
              // ),
              SizedBox(height: Sizes.screenHeight() * 0.03),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (!HelperFunctions.validateLogin()) {
                        return;
                      }
                      videosCubit.addLikeToVideo(
                        videoId: video.id,
                      );
                    },
                    child: Icon(
                      isLikeVideo ? Icons.favorite : Icons.favorite_border,
                      size: 35.r,
                      color: Colors.red,
                    ),
                  ),
                  const BoxHelper(height: 7),
                  Text(
                    '${video.likes?.length}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: Sizes.screenHeight() * 0.03),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (!HelperFunctions.validateLogin()) {
                        return;
                      }
                      // NavigationService.push(
                      //     page: const CommentsScreen(
                      //       blogsId: 0,
                      //     ),
                      //     isNamed: false);
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: videosCubit,
                            ),
                          ],
                          child: BlocBuilder<VideosCubit, VideosState>(
                            builder: (context, state) {
                              var videosCubit = context.read<VideosCubit>();
                              return CommentsListWidget(
                                comments: video.comments,
                                commentController:
                                    videosCubit.commentController,
                                isLike: videosCubit.isLikeVideo(index: index),
                                likesCount: video.likes?.length.toString(),
                                onLike: () => videosCubit.addLikeToVideo(
                                    videoId: video.id),
                                onSendComment: () =>
                                    videosCubit.addCommentToVideo(
                                  videoId: video.id,
                                  index: index,
                                  context: context,
                                ), commentFocus: videosCubit.commentFocusNode,
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.comment,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    video.comments?.length.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: Sizes.screenHeight() * 0.03),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (!HelperFunctions.validateLogin()) {
                        return;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllConversationsScreen(
                              link: link,
                            ),
                          ));
                    },
                    child: const MirrorWidget(
                      child: Icon(
                        Icons.reply,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '5',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: Sizes.screenHeight() * 0.03),
              Column(
                children: [
                  InkWell(
                    onTap: () => Share.share(link),
                    child: const Icon(
                      Icons.share_outlined,
                      textDirection: TextDirection.ltr,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '5',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

                // SizedBox(height: Sizes.screenHeight() * 0.03),
                ReportAndBlockMenu(
                  reportTypeId: video.id,
                  reportType: ReportType.live,
                  iconColor: Colors.white,
                  me: video.userId == HelperFunctions.currentUser?.id,
                ),

            ],
          ),
        ),
      ],
    );
  }
}
