import 'dart:developer';

import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/chat/components/home_components/components/view_story_screen.dart';
import 'package:creen/features/chat/stories_details_screen.dart';
import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:creen/features/subject/repo/update_seen_blogs_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/chat/components/home_components/components/story_screen_ui.dart';
import '../../../features/localization/manager/app_localization.dart';
import '../../../features/subject/view/widgets/subject_item.dart';
import '../../../features/subject/viewModel/blogs/blogs_cubit.dart';

class BlogsView extends StatelessWidget {
  const BlogsView({
    super.key,
    required this.blogsCubit,
  });

  final BlogsCubit blogsCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogsCubit, BlogsState>(
      builder: (context, state) {
        // log('storiesCubit!.stories.length ${storiesCubit!.stories.length}');
        if (state is BlogsLoading) {
          return const LoaderWidget(
            color: Colors.white,
          );
        }
        return RefreshIndicator(
          color: Colors.black,
          onRefresh: () => blogsCubit.getBlogs(
            context,
            isInit: true,
          ),
          child: Column(
            children: [
              BlocProvider<StoriesCubit>.value(
                value: storiesCubit!,
                child: Directionality(
                  textDirection:
                  localization.currentLanguage.toString() == "en"
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Container(
                      height: Sizes.screenHeight() * 0.15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/images/story_bg.png"),fit: BoxFit.fill),
                      ),
                      child: Column(
                        children: [
                          if (StoriesCubit() != null)
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 15.r),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    StoryScreenUI(
                                      storiesCubit: storiesCubit!,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    // direction: Axis.vertical,
                    children: [
                      if (storiesCubit != null &&
                          storiesCubit!.stories != null &&
                          storiesCubit!.stories.isNotEmpty &&
                          state is! StoriesLoading)
                      Container(
                        width: Sizes.screenWidth(),
                        height: Sizes.screenHeight() * 0.3,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                // log('storiesCubit?.stories[index].story?[0].image ${storiesCubit?.stories[index].story?[0].image}');
                // log('storiesCubit!.stories[index].profile! ${storiesCubit!.stories[index].profile!}');
                            log('index $index');
                            log('length ${storiesCubit!.stories.length >= 5 ? 6 : storiesCubit!.stories.length}');
                            if (index < 5) {
                              return InkWell(
                                onTap: () {
                                  NavigationService.push(
                                    page: BlocProvider.value(
                                      value: storiesCubit!,
                                      child: ViewStoryScreen(
                                        initStoryPage: index,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  alignment: HelperFunctions.isArabic
                                      ? Alignment.bottomRight
                                      : Alignment.bottomLeft,
                                  children: [
                                    if (storiesCubit!.stories.isNotEmpty &&
                                        storiesCubit?.stories[index] != null)
                                      Container(
                                        width: Sizes.screenWidth() * 0.31,
                                        height: Sizes.screenHeight() * 0.3,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: storiesCubit?.stories[index]
                                                          .story?[0].image !=
                                                      null
                                                  ? NetworkImage(storiesCubit!
                                                      .stories[index].story![0].image)
                                                  : const AssetImage(
                                                          'assets/images/playbutton.png')
                                                      as ImageProvider<Object>,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    if (storiesCubit!.stories.isNotEmpty)
                                      Container(
                                        width: 45,
                                        height: 45,
                                        margin: const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.primaries[
                                                    index >= 17 ? 0 : index + 1],
                                                width: 3.0),
                                            image: DecorationImage(
                                              image: storiesCubit!
                                                          .stories[index].profile !=
                                                      null
                                                  ? NetworkImage(storiesCubit!
                                                      .stories[index].profile!)
                                                  : const AssetImage(personProfile)
                                                      as ImageProvider<Object>,
                                              fit: BoxFit.cover,
                                            )),
                                      )
                                  ],
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  NavigationService.push(
                                    page: BlocProvider.value(
                                        value: storiesCubit!,
                                        child: const StoriesDetailsScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'more'.translate,
                                        style: TextStyle(
                                          color: const Color(0xFF3B9889),
                                          fontSize: 20.r,
                                        ),
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        color: const Color(0xFF3B9889),
                                        size: 20.r,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          padding: EdgeInsets.zero,
                          itemCount: storiesCubit!.stories.length >= 5
                              ? 6
                              : storiesCubit!.stories.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        height:
                            Sizes.screenHeight() /**0.84*/ * blogsCubit.blogs.length,
                        child: ListView.builder(
                          controller: blogsCubit.scrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          // primary: false,
                          // shrinkWrap: true,
                          itemCount: blogsCubit.blogs.length,
                          itemBuilder: (context, i) {
                            var post = blogsCubit.blogs[i];
                            // log('post id ${post.id}');
                            UpdateSeenBlogsRepo.updateSeen(blogId: post.id);
                            return SubjectItem(
                              // key: ValueKey(post.id),
                              isFirstItem: i == 0,
                              hasRetweeted:
                                  blogsCubit.isRetweetedBlog(postId: post.id),
                              publisherId: post.userId,
                              blogsCubit: blogsCubit,
                              postId: post.id,
                              cookerImage: post.user?.profile,
                              postImage: post.image,
                              isFollow: post.user?.isFollow ?? false,
                              isLike: post.isLike ?? false,
                              cookerName: post.user?.name,
                              likeCount: post.likesCount?.toString(),
                              postDesc: post.content,
                              postTitle: post.title,
                              categoryName: post.category?.name,
                              blogs: post,
                              showAd: i % 3 == 0,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/*
const Icon(
Icons.card_giftcard,
size: 25,
color: Colors.pinkAccent,
)*/
