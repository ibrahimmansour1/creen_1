import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/subject/viewModel/blogDetails/blog_details_cubit.dart';
import 'package:creen/features/subject/viewModel/blogs/blogs_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';
import '../../repo/add_comment_to_post_repo.dart';

part 'add_comment_to_post_state.dart';

class AddCommentToPostCubit extends Cubit<AddCommentToPostState> {
  AddCommentToPostCubit() : super(AddCommentToPostInitial());

  var commentController = TextEditingController();
   FocusNode focusNode = FocusNode();
  Future<void> addComment(
    BuildContext context, {
    required int? blogId,
  }) async {
    var isFromBlogDetails =
        ModalRoute.of(context)?.settings.name == RoutePaths.blogDetails;

    if (commentController.text.isEmpty) {
      return;
    }
    emit(AddCommentToPostLoading());

    var commentData = await AddCommentToPostRepo.addCommentToPost(
      context,
      body: {
        'comment': commentController.text,
        'blog_id': blogId,
      },
    );
    if (commentData == null) {
      emit(AddCommentToPostError());
      return;
    }

    if (commentData.status == true) {
      commentController.clear();
      var comment = commentData.data;
/*      print("commentData userName   ==>${commentData.data!.userName}");
      print("commentData logo       ==>${commentData.data!.logo}");
      print("Comment userName   ==>${comment?.userName}");
      print("Comment logo       ==>${comment?.logo}");*/
      comment?.userName = HelperFunctions.currentUser?.name;
      comment?.logo = HelperFunctions.currentUser?.profile;
      print("Comment userName${comment?.userName}");
      print("Comment logo${comment?.logo}");
      context.read<BlogsCubit>().addNewCommentToPost(
            blogId: blogId,
            commentJson: comment!.toJson(),
          );

      // comment?.userName = HelperFunctions.currentUser?.name;
      // comment?.logo = HelperFunctions.currentUser?.profile;
      try {
if(context.mounted) {
  context.read<BlogDetailsCubit>().addNewCommentToPost(
              blogId: blogId,
              commentJson: comment!.toJson(),
            );
}

      } catch (_) {
        // TODO
      }
      emit(AddCommentToPostDone());
    } else {
      Fluttertoast.showToast(
        msg: commentData.message ?? '',
      );
      emit(AddCommentToPostError());
    }
  }
  Future<void> editComment(
      BuildContext context, {
        required int? blogId,
      }) async {

/*    var commentData = await AddCommentToPostRepo.addCommentToPost(
      context,
      body: {
        'comment': commentController.text,
        'blog_id': blogId,
      },
    );
    if (commentData == null) {
      emit(AddCommentToPostError());
      return;
    }

    if (commentData.status == true) {
      commentController.clear();
      var comment = commentData.data;
*//*      print("commentData userName   ==>${commentData.data!.userName}");
      print("commentData logo       ==>${commentData.data!.logo}");
      print("Comment userName   ==>${comment?.userName}");
      print("Comment logo       ==>${comment?.logo}");*//*
      comment?.userName = HelperFunctions.currentUser?.name;
      comment?.logo = HelperFunctions.currentUser?.profile;
      print("Comment userName${comment?.userName}");
      print("Comment logo${comment?.logo}");
      context.read<BlogsCubit>().addNewCommentToPost(
        blogId: blogId,
        commentJson: comment!.toJson(),
      );

      // comment?.userName = HelperFunctions.currentUser?.name;
      // comment?.logo = HelperFunctions.currentUser?.profile;
      try {
        if(context.mounted) {
          context.read<BlogDetailsCubit>().addNewCommentToPost(
            blogId: blogId,
            commentJson: comment!.toJson(),
          );
        }

      } catch (_) {
        // TODO
      }
      emit(AddCommentToPostDone());
    } else {
      Fluttertoast.showToast(
        msg: commentData.message ?? '',
      );
      emit(AddCommentToPostError());
    }*/
  }
  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}
