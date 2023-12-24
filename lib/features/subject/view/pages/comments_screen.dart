import 'package:creen/features/subject/viewModel/addCommentToPost/add_comment_to_post_cubit.dart';
import 'package:creen/features/subject/viewModel/blogs/blogs_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/comments_list_widget.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key, required this.blogsId}) : super(key: key);
  final int blogsId;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late BlogsCubit blogsCubit;
  late AddCommentToPostCubit addCommentToPostCubit;


  @override
  void initState() {
    blogsCubit = context.read<BlogsCubit>();
    addCommentToPostCubit = context.read<AddCommentToPostCubit>();
    // addCommentToPostCubit.focusNode = FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    addCommentToPostCubit.focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocBuilder<BlogsCubit, BlogsState>(
      builder: (context, state) {
        var blogById = blogsCubit.blogById(
          widget.blogsId,
          context,
        );

        return CommentsListWidget(
            comments: blogById?.comments,
            onLike: () => blogsCubit.addLikeToPost(
                  context,
                  postId: widget.blogsId,
                ),
            isLike: blogById?.isLike,
            likesCount: blogById?.likesCount?.toString(),
            commentController: addCommentToPostCubit.commentController,
            commentFocus: addCommentToPostCubit.focusNode,

            onSendComment: () {
              if(editing){

                /*addCommentToPostCubit.editComment(
                  context,
                  blogId: widget.blogsId,
                );*/

              }
              else {
                addCommentToPostCubit.addComment(
                  context,
                  blogId: widget.blogsId,
                );
              }
            },
        onDelete: () {
          // print("delete comment");
          // blogsCubit.deleteCommentToPost(commentId:blogById?.comments );
        },);
      },
    );
  }
}
