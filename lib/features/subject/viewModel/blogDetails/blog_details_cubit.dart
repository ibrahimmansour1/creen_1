import 'package:bloc/bloc.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:equatable/equatable.dart';

import '../../model/blogs_model.dart';
import '../../repo/blog_details_repo.dart';

part 'blog_details_state.dart';

class BlogDetailsCubit extends Cubit<BlogDetailsState> {
  BlogDetailsCubit({
    required this.blogId,
  }) : super(BlogDetailsInitial());
  final int? blogId;

  Blogs? _blogDetailsData;
  Blogs? get blogDetailsData => _blogDetailsData;

  bool get hasRetweetedBlog =>
      (_blogDetailsData?.retweets?.indexWhere(
              (e) => e.userId == HelperFunctions.currentUser?.id) ??
          -1) >=
      0;

  Future<void> getBlogDetailsData() async {
    try {
      emit(BlogDetailsLoading());
      var response = await BlogDetailsRepo.getBlogDetails(blogId: blogId);

      if (response == null) {
        return;
      }
      if (response.status == true) {
        _blogDetailsData = response.data;
      }
      emit(BlogDetailsDone());
    } catch (_) {
      emit(BlogDetailsError());
      // TODO
    }
  }

  void changeFollowStatus({
    int? publisherId,
  }) {
    _blogDetailsData?.user?.isFollow =
        !(_blogDetailsData?.user?.isFollow ?? false);
    emit(BlogFollowStateChanged(
        isFollow: _blogDetailsData?.user?.isFollow ?? false));
  }

  void toggleFavBtn() {
    var isLike = _blogDetailsData?.isLike ?? false;
    if (isLike && (_blogDetailsData?.likesCount ?? 0) > 0) {
      _blogDetailsData?.likesCount = (_blogDetailsData?.likesCount ?? 0) - 1;
    } else {
      _blogDetailsData?.likesCount = (_blogDetailsData?.likesCount ?? 0) + 1;
    }
    _blogDetailsData?.isLike = !(_blogDetailsData?.isLike ?? false);
    emit(BlogFavStateChanged(isFav: _blogDetailsData?.isLike ?? false));

  }

  void toggleRetweet({
    required Retweet retweet,
  }) {
    _blogDetailsData?.retweets?.add(retweet);
    emit(BlogRetweetStateChanged(
        length: _blogDetailsData?.retweets?.length ?? 0));
  }

  void addNewCommentToPost(
      {int? blogId, required Map<String, dynamic> commentJson}) {
    _blogDetailsData?.comments?.add(
      Comment.fromJson(
        commentJson,
      ),
    );
    emit(BlogCommentStateChanged(
        length: _blogDetailsData?.comments?.length ?? 0));
  }
}
