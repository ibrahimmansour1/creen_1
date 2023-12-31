import 'dart:math';

import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/chat_screen.dart';
import '../../../../core/utils/widgets/comments_list_widget.dart';
import '../../../../core/utils/widgets/mirror_widget.dart';
import '../../../../core/utils/widgets/report_and_block_menu.dart';
import '../../../videos/viewModel/videos/videos_cubit.dart';

class GridViewItem extends StatelessWidget {
  const GridViewItem({
    super.key,
    required this.liveImage,
    required this.profileImage,
    required this.name,
    required this.address,
    required this.screenActive,
    required this.liveCubit,
    required this.index,
    required this.itemTap,
    // required this.video,
  });

  final String? liveImage;
  final String? profileImage;
  final String name;
  final String address;
  final bool screenActive;
  final VideosCubit liveCubit;
  final int index;
  final void Function()? itemTap;

  // Widget Function() video;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: itemTap,
      child: Container(
        height: screenActive ? 400 : 200,
        width: screenActive ? 600 : 300,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: const Alignment(0, 0.8),
        decoration: BoxDecoration(
          color: liveImage == null
              ? Color(0xff + Random().nextInt(0xffffffff - 0xff))
              : null,
          image: DecorationImage(
              image: liveImage != null
                  ? NetworkImage(liveImage!)
                  : const AssetImage('assets/images/liveee.png')
                      as ImageProvider<Object>,
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            // video(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (screenActive) ...[
                  SizedBox(height: Sizes.screenHeight() * 0.03),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (!HelperFunctions.validateLogin()) {
                            return;
                          }
                          liveCubit.addLikeToVideo(
                            videoId: liveCubit.videos[index].id,
                          );
                        },
                        child: Icon(
                          liveCubit.isLikeVideo(index: index)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 35.r(),
                          color: Colors.red,
                        ),
                      ),
                      const BoxHelper(height: 7),
                      Text(
                        '${liveCubit.videos[index].likes?.length}',
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
                                  value: liveCubit,
                                ),
                              ],
                              child: BlocBuilder<VideosCubit, VideosState>(
                                builder: (context, state) {
                                  VideosCubit liveCubit =
                                      context.read<VideosCubit>();
                                  return CommentsListWidget(
                                    comments: liveCubit.videos[index].comments,
                                    commentController:
                                        liveCubit.commentController,
                                    isLike: liveCubit.isLikeVideo(index: index),
                                    likesCount: liveCubit
                                        .videos[index].likes?.length
                                        .toString(),
                                    onLike: () => liveCubit.addLikeToVideo(
                                        videoId: liveCubit.videos[index].id),
                                    onSendComment: () =>
                                        liveCubit.addCommentToVideo(
                                      videoId: liveCubit.videos[index].id,
                                      index: index,
                                      context: context,
                                    ),
                                    commentFocus: liveCubit.commentFocusNode,
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
                        liveCubit.videos[index].comments?.length.toString() ??
                            '',
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
                                  link: HelperFunctions.videoShareLink(
                                      videoId: liveCubit.videos[index].id),
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
                        onTap: () => Share.share(
                          HelperFunctions.videoShareLink(
                              videoId: liveCubit.videos[index].id),
                        ),
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
                    reportTypeId: liveCubit.videos[index].id,
                    reportType: ReportType.live,
                    iconColor: Colors.white,
                    me: liveCubit.videos[index].userId ==
                        HelperFunctions.currentUser?.id,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
                Container(
                  color: Colors.grey.shade500.withOpacity(0.4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: !screenActive
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceBetween,
                    textDirection:
                        !screenActive ? TextDirection.ltr : TextDirection.rtl,
                    children: [
                      SizedBox(
                        width: 112.4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenActive ? 20 : null,
                                    fontWeight: FontWeight.bold)),
                            Text(address,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenActive ? 18 : 12)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: profileImage != null
                            ? NetworkImage(profileImage!)
                            : const AssetImage(personProfile)
                                as ImageProvider<Object>,
                        radius: screenActive ? 40 : 22,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
