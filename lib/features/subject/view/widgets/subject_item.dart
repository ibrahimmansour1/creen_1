import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/banner_ad_widget.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/chat_screen.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/core/utils/widgets/star.dart';
import 'package:creen/features/chat/components/chat_components/components/all_messages_screend.dart';
import 'package:creen/features/chat/viewModel/allConversations/all_conversations_cubit.dart';
import 'package:creen/features/follow/viewModel/following/following_cubit.dart';
import 'package:creen/features/profile/presentaion/pages/my_profile.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:creen/features/subject/view/pages/add_subject.dart';
import 'package:creen/features/subject/view/pages/comments_screen.dart';
import 'package:creen/features/subject/view/widgets/trainer_widget.dart';
import 'package:creen/features/subject/view/widgets/youtube_widget.dart';
import 'package:creen/features/subject/viewModel/addCommentToPost/add_comment_to_post_cubit.dart';
import 'package:creen/features/subject/viewModel/blogDetails/blog_details_cubit.dart';
import 'package:creen/features/subject/viewModel/blogs/blogs_cubit.dart';
import 'package:creen/features/subject/viewModel/createBlogs/create_new_blogs_cubit.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/widgets/customized_read_more.dart';
import '../../../../core/utils/widgets/follow_button.dart';
import '../../../../core/utils/widgets/mirror_widget.dart';
import '../../../../core/utils/widgets/report_and_block_menu.dart';
import '../../../follow/viewModel/follow/follow_cubit.dart';
import '../../../follow/viewModel/followers/followers_cubit.dart';
import '../../../market/viewModel/categories/categories_cubit.dart';
import '../../model/blogs_model.dart';

var english = RegExp(r'[a-zA-Z]');

class SubjectItem extends StatefulWidget {
  const SubjectItem({
    Key? key,
    this.isFollow = false,
    this.hasRetweeted = false,
    this.isLike = false,
    this.cookerName,
    this.categoryName,
    this.postTitle,
    this.postDesc,
    this.likeCount,
    this.postImage,
    this.cookerImage,
    required this.blogsCubit,
    this.postId,
    this.publisherId,
    this.showAd = false,
    this.blogs,
    this.isFirstItem = false,
  }) : super(key: key);
  final bool isFollow;
  final bool isLike;
  final bool showAd;
  final bool isFirstItem;
  final bool hasRetweeted;
  final String? cookerName;
  final String? categoryName;
  final String? postTitle;
  final String? postDesc;
  final String? likeCount;
  final String? postImage;
  final String? cookerImage;
  final int? postId;
  final BlogsCubit? blogsCubit;
  final int? publisherId;
  final Blogs? blogs;

  @override
  State<SubjectItem> createState() => _SubjectItemState();
}

class _SubjectItemState extends State<SubjectItem> {
  var controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    if (widget.publisherId == widget.blogsCubit?.blogs.first.userId) {
      log('follow ${widget.isFollow}');
      log('isMe=> ${widget.publisherId == HelperFunctions.currentUser?.id}');
    }

    int currentStep = 0;
    var retweets = widget.blogs?.retweets;
    var link = 'https://www.creen-program.com/blog/view/${widget.blogs?.id}';
    var length = widget.blogs?.images?.length ?? 0;
    int imagesLength =
        widget.blogs?.youtube?.isNotEmpty == true ? length + 1 : length;
    // print("retweets?[0].user?.profile ${retweets?[0].user?.profile}");
    return Column(
      children: [
        Visibility(
          visible: widget.showAd,
          child:const TrainerWidget(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0.r),
          // padding: EdgeInsets.all(10),
          //height: Sizes.screenHeight() * 0.79,
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*    if (retweets?.isNotEmpty == true) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Row(
                        children: [
                          BoxHelper(
                            width: 30,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    retweets?[0].user?.profile ?? '',
                                    height: 30.r,
                                    width: 30.r,
                                  ),
                                ),
                                (retweets?.length ?? 0) >= 2
                                    ? Positioned(
                                        left: -14.r,
                                        child: ClipOval(
                                          child: Image.network(
                                            retweets?[1].user?.profile ?? '',
                                            height: 30.r,
                                            width: 30.r,
                                          ),
                                        ),
                                      )
                                    : const BoxHelper(),
                                (retweets?.length ?? 0) >= 3
                                    ? Positioned(
                                        left: -25.r,
                                        child: ClipOval(
                                          child: Image.network(
                                            retweets?[2].user?.profile ?? '',
                                            height: 30.r,
                                            width: 30.r,
                                          ),
                                        ),
                                      )
                                    : const BoxHelper(),
                              ],
                            ),
                          ),
                          BoxHelper(
                            width: retweets?.length == 1 ? 10 : 25,
                          ),
                          Expanded(
                            child: Text(
                              '${((retweets?.length ?? 0) > 3 ? retweets?.getRange(0, 3) : retweets)?.map((e) => e.userName ?? '').toList().join(', ') ?? ''} ${'shared_this_blog'.translate.replaceAll(retweets?.length == 1 ? 'وا' : '', '')}',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ],
           */
              SizedBox(height: 5.h,),
              Padding(
                padding: EdgeInsets.only(right: 10.r),
                child: Row(
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          NavigationService.push(
                            page: MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (_) => FollowingCubit(
                                    userId: widget.publisherId,
                                  ),
                                ),
                                if (widget.blogsCubit != null)
                                  BlocProvider.value(
                                    value: widget.blogsCubit!,
                                  ),
                                BlocProvider(
                                  create: (_) => FollowersCubit(
                                    userId: widget.publisherId,
                                  ),
                                ),
                                BlocProvider(
                                  create: (_) => ProfileCubit(
                                    userId: widget.publisherId,
                                  ),
                                ),
                              ],
                              // child: const OthersProfileScreen(),
                              child: const MyProfileScreen(),
                            ),
                            isNamed: false,
                          );
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              backgroundImage: widget.cookerImage != null
                                  ? NetworkImage(
                                      widget.cookerImage!,
                                    )
                                  : const AssetImage(personProfile)
                                      as ImageProvider,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.cookerName ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: MainTheme.authTextStyle.copyWith(
                                    fontSize: 14.r,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  widget.categoryName ?? '',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.publisherId ==
                            HelperFunctions.currentUser?.id
                        ? BlocBuilder<BlogsCubit, BlogsState>(
                            builder: (context, state) {
                              if (state is DeleteBlogsLoading) {
                                return const LoaderWidget();
                              }
                              return PopupMenuButton(
                                onSelected: (v) {
                                  if (v == 'delete') {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          'delete'.translate,
                                        ),
                                        content: Text(
                                          'do_you_want_to_scan'.translate,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              NavigationService.goBack();
                                              widget.blogsCubit
                                                  ?.deleteBlogsById(
                                                context,
                                                widget.postId,
                                              );
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
                                  } else if (v == 'edit') {
                                    NavigationService.push(
                                        page: MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (_) =>
                                                  CategoriesCubit(),
                                            ),
                                            BlocProvider.value(
                                              value: widget.blogsCubit!,
                                            ),
                                            BlocProvider(
                                              create: (context) =>
                                                  CreateNewBlogsCubit(
                                                      blog: widget.blogs),
                                            ),
                                          ],
                                          child: const AddSubjectScreen(),
                                        ),
                                        isNamed: false);
                                  }
                                },
                                itemBuilder: (_) => [
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text(
                                      'delete'.translate,
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Text(
                                      'edit'.translate,
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : Row(
                            children: [
                              // const StarIcon(),
                              // InkWell(
                              //     onTap: () {
                              //       // print('cooker cooker name =====> ${widget.cookerName}');
                              //       // print('cooker cooker name =====> ${widget.cookerImage}\n\n\n\n');
                              //       if (!HelperFunctions.validateLogin()) {
                              //         return;
                              //       }
                              //       NavigationService.push(
                              //           page: AllMessagesScreen(
                              //         allConversationsCubit:
                              //             AllConversationsCubit(),
                              //         recieverId: widget.publisherId,
                              //         conversationId: null,
                              //         userName: widget.cookerName,
                              //         profilePic: widget.cookerImage,
                              //         timeAgo: null,
                              //       ));
                              //     },
                              //     child: SvgPicture.asset(
                              //       "assets/images/chat.svg",
                              //       width:
                              //           MediaQuery.of(context).size.height *
                              //               .035,
                              //       color: Colors.black,
                              //     )),
                              // SizedBox(
                              //   width: 10.w,
                              // ),
                              Visibility(
                                visible: widget.blogs?.userId !=
                                    HelperFunctions.currentUser?.id,
                                child: BlocBuilder<FollowCubit, FollowState>(
                                  builder: (context, state) {
                                    if (state is FollowLoading) {
                                      return const LoaderWidget();
                                    }
                                    return FollowButton(
                                        onPressed: () {
                                          if (!HelperFunctions
                                              .validateLogin()) {
                                            return;
                                          }
                                          context.read<FollowCubit>().follow(
                                                context,
                                                userId: widget.publisherId,
                                                isFollow: widget.isFollow,
                                              );
                                        },
                                        isFollow: widget.isFollow);
                                  },
                                ),
                              ),
                              ReportAndBlockMenu(
                                reportTypeId: widget.blogs?.id,
                                reportType: ReportType.post,
                              ),
                            ],
                          )
                  ],
                ),
              ),
              SizedBox(height: 5.h,),
              widget.blogs?.images?.isNotEmpty == true ||
                      widget.blogs?.youtube?.isNotEmpty == true
                  ? StatefulBuilder(builder: (context, setState) {
                      return Column(
                        children: [
                          CarouselSlider(
                            items: List.generate(
                              imagesLength,
                              (index) {
                                // var singleImage = widget.blogs?.images?[index].url;
                                // print("widget.blogs!.youtube! ${widget.blogs!.youtube!}");
                                return index == imagesLength - 1 &&
                                        widget.blogs?.youtube?.isNotEmpty ==
                                            true
                                    ? YoutubeWidget(
                                        youtubeLink:
                                            widget.blogs!.youtube!.contains('&')
                                                ? widget.blogs!.youtube!
                                                    .split('&')
                                                    .first
                                                : widget.blogs!.youtube!,
                                        isFirstItem: widget.isFirstItem,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          if (kDebugMode) {
                                            // print("objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject");
                                            print("imagesLength $imagesLength");
                                          }
                                          showImageViewerPager(
                                            context,
                                            MultiImageProvider(
                                              List.generate(
                                                widget.blogs?.youtube
                                                            ?.isNotEmpty ==
                                                        true
                                                    ? imagesLength - 1
                                                    : imagesLength,
                                                (i) => networkImage(
                                                        url: widget
                                                                .blogs
                                                                ?.images?[i]
                                                                .url ??
                                                            '')
                                                    .image,
                                              ),
                                              initialIndex: index,
                                            ),
                                            swipeDismissible: true,
                                            doubleTapZoomable: true,
                                          );
                                        },
                                        child: networkImage(
                                            url: widget.blogs?.images?[index]
                                                    .url ??
                                                ''),
                                      );
                              },
                            ),
                            carouselController: controller,
                            options: CarouselOptions(
                              initialPage: currentStep,
                              enableInfiniteScroll: false,
                              height: Sizes.screenHeight() * 0.45,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentStep = index;
                                });
                              },
                              viewportFraction: 1,
                            ),
                          ),
                          Visibility(
                            visible: imagesLength > 1,
                            child: DotsIndicator(
                              onTap: (index) {
                                setState(() {
                                  var int = index.toInt();
                                  controller.animateToPage(int);
                                  // setState((){

                                  // });
                                });
                              },
                              dotsCount: imagesLength,
                              position: currentStep.toDouble(),
                              decorator: const DotsDecorator(
                                color: Colors.black45, // Inactive color
                                activeColor: Colors.black,
                              ),
                            ),
                          )
                        ],
                      );
                    })
                  : InkWell(
                      onTap: () {
                        showImageViewer(
                          context,
                          NetworkImage(widget.postImage ?? ''),
                          swipeDismissible: true,
                          doubleTapZoomable: true,
                        );
                      },
                      child: networkImage(
                        url: widget.postImage ?? '',
                      )),
              Padding(
                // padding: const EdgeInsets.all(8.0),
                padding: widget.postTitle != null && widget.postDesc != null
                    ? EdgeInsets.symmetric(horizontal: 10.r)
                    : EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.postTitle != null
                        ? Container(
                            // alignment: Alignment.topRight,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Text(
                              widget.postTitle ?? '',
                              textDirection:
                                  (english.hasMatch(widget.postTitle ?? ''))
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                              style: MainTheme.authTextStyle.copyWith(
                                  color: Colors.black,
                                  fontSize: 18.r,
                                  fontFamily: "Cairo"),
                            ))
                        : SizedBox(),
                    widget.postTitle != null
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: CustomizedReadMore(data: widget.postDesc),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 5.r),
                // padding: EdgeInsets.fromLTRB(15.r, 10, 15.r, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/eye.svg",
                                  width:
                                      MediaQuery.of(context).size.height * .03,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                            // const Icon(
                            //   Icons.visibility,
                            //   // color: Colors.red,
                            // ),
                            const BoxHelper(
                              width: 5,
                            ),
                            Text(
                              '${widget.blogs?.seen ?? 0}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                         const Text(
                          "${122}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Image.asset(
                          "assets/images/gift.png",
                          width: MediaQuery.of(context).size.height * .03,
                        ),

                      ],
                    ),

                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r),
                // padding: EdgeInsets.fromLTRB(15.r, 10, 15.r, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Divider(
                    //   color: MainStyle.mainGray,
                    //   thickness: 1,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomizedReactColumn(
                            reactWidget: InkWell(
                              onTap: () {
                                if (!HelperFunctions.validateLogin()) {
                                  return;
                                }
                                widget.blogsCubit?.addLikeToPost(
                                  context,
                                  postId: widget.postId,
                                );
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    widget.isLike
                                        ? "assets/images/red_heart.svg"
                                        : "assets/images/heart.svg",
                                    width: MediaQuery.of(context).size.height *
                                        .03,
                                    color:
                                        widget.isLike ? null : Colors.grey[600],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "${widget.blogs?.likesCount}",
                                    style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[600],),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CustomizedReactColumn(
                            reactWidget: InkWell(
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/chat.svg",
                                    width: MediaQuery.of(context).size.height *
                                        .03,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "${widget.blogs?.commentsCount}",
                                    style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[600],),
                                  ),
                                ],
                              ),
                              onTap: () {
                                if (widget.blogsCubit == null) {
                                  return;
                                }
                                if (!HelperFunctions.validateLogin()) {
                                  return;
                                }
                                var isFromBlogDetails =
                                    ModalRoute.of(context)?.settings.name ==
                                        RoutePaths.blogDetails;
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      if (widget.blogsCubit != null)
                                        BlocProvider<BlogsCubit>.value(
                                          value: widget.blogsCubit!,
                                        ),
                                      if (isFromBlogDetails) ...[
                                        BlocProvider<BlogDetailsCubit>.value(
                                          value:
                                              context.read<BlogDetailsCubit>(),
                                        ),
                                      ],
                                      BlocProvider(
                                        create: (context) =>
                                            AddCommentToPostCubit(),
                                      ),
                                    ],
                                    child: CommentsScreen(
                                      blogsId: widget.postId ?? 0,
                                    ),
                                  ),
                                );
                                // NavigationService.push(
                                //     page: MultiBlocProvider(
                                //       providers: [
                                //         if (blogsCubit != null)
                                //           BlocProvider<BlogsCubit>.value(
                                //             value: blogsCubit!,
                                //           ),
                                //         BlocProvider(
                                //           create: (context) =>
                                //               AddCommentToPostCubit(),
                                //         ),
                                //       ],
                                //       child: CommentsScreen(
                                //         blogsId: postId ?? 0,
                                //       ),
                                //     ),
                                //     isNamed: false);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Share.share(
                                link,
                              );
                            },
                            child: CustomizedReactColumn(
                              reactWidget: InkWell(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/share-f.svg",
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        color: Colors.grey[600],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "${100}",
                                        style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[600],),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder<BlogsCubit, BlogsState>(
                            builder: (context, state) {
                              return CustomizedReactColumn(
                                reactWidget: InkWell(
                                  onTap: state ==
                                          RetweetBlogsLoading(
                                              blogsId: widget.blogs?.id ?? 0)
                                      ? null
                                      : () {
                                          if (!HelperFunctions
                                              .validateLogin()) {
                                            return;
                                          }
                                          if (widget.blogsCubit == null ||
                                              widget.hasRetweeted) {
                                            return;
                                          }
                                          if (kDebugMode) {
                                            print(
                                                "widget.blogs?.id ${widget.blogs?.id}");
                                          }
                                          widget.blogsCubit?.retweetBlogsById(
                                              context, widget.blogs?.id);
                                        },
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/sync.svg",
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        color: widget.hasRetweeted
                                            ? Colors.green
                                            : Colors.grey[600],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "${widget.blogs?.retweetsCount}",
                                        style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[600],),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (!HelperFunctions.validateLogin()) {
                                return;
                              }
                              NavigationService.push(
                                page: AllConversationsScreen(
                                  link: link,
                                ),
                              );
                            },
                            child: CustomizedReactColumn(
                              reactWidget: InkWell(
                                child: MirrorWidget(
                                  mirror:
                                      HelperFunctions.currentLanguage == 'ar'
                                          ? false
                                          : true,
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/share.svg",
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                        color: Colors.grey[600],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "${100}",
                                        style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[600],),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.showAd,
          child: BannerAdWidget(),
        ),

      ],
    );
  }

  Image networkImage({required String url}) => Image.network(
        url,
        errorBuilder: (context, error, stackTrace) => const SizedBox(),
        fit: BoxFit.cover,
        width: double.infinity,
        // height: Sizes.screenHeight() * 0.5,
      );
}

class CircleRetweetImage extends StatelessWidget {
  const CircleRetweetImage({Key? key, required this.image}) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        image ??
            'https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403',
        height: 20.r,
        width: 20.r,
      ),
    );
  }
}

class CustomizedReactColumn extends StatelessWidget {
  const CustomizedReactColumn({
    Key? key,
    this.count,
    required this.reactWidget,
  }) : super(key: key);
  final String? count;
  final Widget reactWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        reactWidget,
      ],
    );
  }
}
