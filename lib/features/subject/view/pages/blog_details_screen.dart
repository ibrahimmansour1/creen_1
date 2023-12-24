import 'dart:developer';

import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/subject/viewModel/blogDetails/blog_details_cubit.dart';
import 'package:creen/features/subject/viewModel/blogs/blogs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../widgets/subject_item.dart';

class BlogDetailsScreen extends StatefulWidget {
  const BlogDetailsScreen({super.key});

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  late BlogDetailsCubit blogDetailsCubit;

  @override
  void initState() {
    blogDetailsCubit = context.read<BlogDetailsCubit>()..getBlogDetailsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.black45],
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            title: 'blogs',
            back: true,
          ),
        ),
        // backgroundColor: Colors.transparent,
        body: BlocBuilder<BlogDetailsCubit, BlogDetailsState>(
          builder: (context, state) {
            if (state is BlogDetailsLoading) {
              return const Center(
                child: LoaderWidget(),
              );
            }
            var post = blogDetailsCubit.blogDetailsData;
            if (post == null) {
              return const SizedBox();
            }
            log('${post.comments?.length}', name: 'comment_length');
            return SubjectItem(
              blogsCubit: context.read<BlogsCubit>(),
              blogs: post,
              hasRetweeted: blogDetailsCubit.hasRetweetedBlog,
              publisherId: post.userId,
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
              showAd: true,
            );
          },
        ),
      ),
    );
  }
}
