// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/follow/viewModel/follow/follow_cubit.dart';
import 'package:creen/features/subject/repo/delete_blogs_repo.dart';
import 'package:creen/features/subject/viewModel/blogDetails/blog_details_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/blogs_model.dart';
import '../../repo/blogs_repo.dart';
import '../../repo/add_like_to_post_repo.dart';
import '../../repo/retweet_repo.dart';
part 'blogs_state.dart';

class BlogsCubit extends Cubit<BlogsState> {
  BlogsCubit({
    this.userId,
  }) : super(BlogsInitial());
  final int? userId;

  Future<void> getBlogs(
    context, {
    bool isInit = false,
  }) async {
    if (isInit) {
      _page = 1;
      _hasNext = false;
      _blogs?.clear();
    }

    emit(
      _page > 1 ? BlogsLoadingMore() : BlogsLoading(),
    );

    var blogsData = await BlogsRepo.getBlogs(
      context,
      page: _page,
      userId: userId,
    );

    if (blogsData == null) {
      emit(Error());
      return;
    }

    if (blogsData.status == true) {
      if (_page > 1) {
        _blogs?.addAll(
          blogsData.data!.data!.map(
            (e) => e,
          ),
        );
      } else {
        _blogs = blogsData.data?.data;
      }
      _hasNext =
          (blogsData.data?.lastPage ?? 0) > (blogsData.data?.currentPage ?? 0);
      if (_hasNext) {
        _page++;
      }
      emit(Done());
    } else {
      emit(Error());
    }
  }

  Future<void> addLikeToPost(
    BuildContext context, {
    int? postId,
  }) async {
    var name2 = ModalRoute.of(context)?.settings.name;
    log('name $name2');
    var isFromBlogDetails = name2 == RoutePaths.blogDetails;
    if (isFromBlogDetails) {
      log('correct');

      // return;
    }
    bool isLike = false;
    var index = _blogs?.indexWhere(
          (e) => e.id == postId,
        ) ??
        -1;

    if (index >= 0) {
      isLike = (_blogs![index].isLike ?? false);
      // log("is ${isLike}");
    } else if (index < 0 && !isFromBlogDetails) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ ما يرجى إعادة المحاولة',
      );
      return;
    } else if (isFromBlogDetails) {
      isLike =
          (context.read<BlogDetailsCubit>().blogDetailsData?.isLike ?? false);
    }
    // isLike = (_blogs![index].isLike ?? false);
    // _blogs![index].isLike = !(blogs[index].isLike ?? false);
    // var likeCount = _blogs?[index].likesCount ?? 0;
    // if (isLike && likeCount > 0) {
    //   _blogs?[index].likesCount = likeCount - 1;
    // } else {
    //   _blogs?[index].likesCount = likeCount + 1;
    // }
    _toggleBlogDetailsFav(context: context, index: index);

    log('isLike $isLike');
    emit(
      AddLikeToPostLoading(
        postId: postId ?? 0,
      ),
    );
    var likeData = await AddLikeToPostRepo.like(
      context,
      body: {
        'like': isLike ? 2 : 1,
        'blog_id': _blogs![index].id,
      },
    );
    if (likeData == null) {
      // _blogs![index].isLike = !(blogs[index].isLike ?? false);
      // isLike = (_blogs![index].isLike ?? false);
      // if (isLike && likeCount > 0) {
      //   _blogs?[index].likesCount = likeCount + 1;
      // } else {
      //   _blogs?[index].likesCount = likeCount - 1;
      // }
      _toggleBlogDetailsFav(context: context, index: index);
emit(Done());
      Fluttertoast.showToast(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
      );
      emit(Error());
      return;
    }
    if (likeData.status == true) {

      // _toggleBlogDetailsFav(context: context, index: index);

      emit(Done());

    } else {
      Fluttertoast.showToast(
        msg: 'حدث خطأ ما يرجى إعادة المحاولة',
      );
      // _blogs![index].isLike = !(blogs[index].isLike ?? false);
      // isLike = (_blogs![index].isLike ?? false);
      // if (isLike && likeCount > 0) {
      //   _blogs?[index].likesCount = likeCount + 1;
      // } else {
      //   _blogs?[index].likesCount = likeCount - 1;
      // }

      emit(Error());
    }
  }

  Future<void> followPublisher(
    BuildContext context, {
    int? publisherId,
  }) async {
    var followCubit = context.read<FollowCubit>();
    var publisherPosts = _blogs
            ?.where(
              (element) => element.userId == publisherId,
            )
            .toList() ??
        [];
    if (publisherPosts.isEmpty) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ ما يرجى إعادة المحاولة',
      );
      return;
    }
    var isFollow = publisherPosts.first.user?.isFollow ?? false;

    for (var index = 0; index < _blogs!.length; index++) {
      var singleBlog = _blogs![index];
      if (singleBlog.userId == publisherId) {
        singleBlog.user?.isFollow = !isFollow;
      }
    }
    emit(
      FollowPublisher(
        userId: publisherId ?? 0,
      ),
    );

    var isFollowed = await followCubit.follow(
      context,
      isFollow: isFollow,
      userId: publisherId,
    );
    if (!isFollowed) {
      for (var index = 0; index < _blogs!.length; index++) {
        var singleBlog = _blogs![index];
        if (singleBlog.userId == publisherId) {
          singleBlog.user?.isFollow = isFollow;
        }
      }
    }
    emit(Done());
  }

  List<Blogs>? _blogs = [];
  int _page = 1;
  bool _hasNext = false;
  List<Blogs> get blogs => [
        ...?_blogs,
      ];
  var scrollController = ScrollController();

  initController(context) {
    scrollController.addListener(
      () => _onScroll(
        context,
      ),
    );
  }

  bool isRetweetedBlog({required int? postId}) {
    var index = _blogs?.indexWhere((element) => element.id == postId) ?? -1;
    if (index < 0) {
      return false;
    }
    var retWeedIndex = _blogs?[index].retweets?.indexWhere(
            (element) => element.userId == HelperFunctions.currentUser?.id) ??
        -1;

    return retWeedIndex >= 0;
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  _onScroll(context) async {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      Fluttertoast.showToast(
        msg: 'جاري تحميل المزيد من العناصر',
      );
      getBlogs(
        context,
      );
    }
  }

  void addNewCommentToPost({
    int? blogId,
    required Map<String, dynamic> commentJson,
  }) {
    var index = _blogs?.indexWhere(
          (element) => element.id == blogId,
        ) ??
        -1;

    if (index >= 0) {
      _blogs![index].comments?.add(
            Comment.fromJson(
              commentJson,
            ),
          );
      emit(Done());

      emit(CommentStateChanged());
    }
  }



  Blogs? blogById(
    int blogId,
    BuildContext context,
  ) {
    var index = _blogs?.indexWhere(
          (element) => element.id == blogId,
        ) ??
        -1;
    try {
      return context.read<BlogDetailsCubit>().blogDetailsData;
    } catch (_) {}

    if (index >= 0) {
      return _blogs?[index];
    }
    return null;
  }

  void insertNewBlog({Map<String, dynamic>? jsonData}) {
    var blogs = Blogs.fromJson(jsonData!);
    var index = (_blogs?.indexWhere((element) => element.id == blogs.id) ?? -1);
    if (index < 0) {
      _blogs?.insert(0, blogs);
    } else {
      _blogs?[index] = blogs;
    }
    emit(BlogsStateChanged(
      length: _blogs?.length ?? 0,
    ));
  }

  Future<void> deleteBlogsById(
    context,
    int? blogId,
  ) async {
    var index = _blogs?.indexWhere(
          (element) => element.id == blogId,
        ) ??
        -1;

    if (index < 0) {
      return;
    }

    emit(
      DeleteBlogsLoading(
        blogsId: blogId ?? 0,
      ),
    );
    try {
      var deleteData = await DeleteBlogsRepo.delete(
        context,
        blogId: blogId,
      );
      if (deleteData == null) {
        Fluttertoast.showToast(
          msg: 'يرجى التحقق من الاتصال بالانترنت',
        );
        emit(Error());
        return;
      }
      if (deleteData.status == true) {
        _blogs?.removeAt(index);
        emit(Done());
      } else {
        Fluttertoast.showToast(
          msg: deleteData.message ?? '',
        );
        emit(Error());
      }
    } catch (error) {
      emit(
        Error(),
      );
      Fluttertoast.showToast(
        msg: error.toString(),
      );
    }
  }

  Future<void> retweetBlogsById(
    BuildContext context,
    int? blogId,
  ) async {
    var isFromBlogDetails =
        ModalRoute.of(context)?.settings.name == RoutePaths.blogDetails;

    var index = _blogs?.indexWhere(
          (element) => element.id == blogId,
        ) ??
        -1;

    if (index < 0 && !isFromBlogDetails) {
      return;
    }

    emit(
      RetweetBlogsLoading(
        blogsId: blogId ?? 0,
      ),
    );
    try {
      var deleteData = await RetweetBlogsRepo.retweet(
        context,
        blogId: blogId,
      );
      if (deleteData == null) {
        Fluttertoast.showToast(
          msg: 'يرجى التحقق من الاتصال بالانترنت',
        );
        emit(Error());
        return;
      }
      if (deleteData.status == true) {
        var retweet = Retweet(
          postId: blogId,
          userId: HelperFunctions.currentUser?.id,
          userName: HelperFunctions.currentUser?.name,
          user: HelperFunctions.currentUser,
        );
        if (index >= 0) {
          var blog = _blogs?[index];
          blog?.retweets?.add(
            retweet,
          );
        }
        if (isFromBlogDetails) {
          context.read<BlogDetailsCubit>().toggleRetweet(
                retweet: retweet,
              );
        }

        emit(Done());
      } else {
        Fluttertoast.showToast(
          msg: deleteData.message ?? '',
        );
        emit(Error());
      }
    } catch (error) {
      emit(
        Error(),
      );
      Fluttertoast.showToast(
        msg: error.toString(),
      );
    }
  }

  void changeFollowStatus({int? publisherId}) {
    var blogIndex = _blogs?.indexWhere(
          (element) => element.userId == publisherId,
        ) ??
        -1;

    if (blogIndex < 0) {
      return;
    }
    var isFollow = _blogs?[blogIndex].user?.isFollow ?? false;
    for (var index = 0; index < _blogs!.length; index++) {
      var singleBlog = _blogs![index];
      if (singleBlog.userId == publisherId) {
        singleBlog.user?.isFollow = !isFollow;
      }
    }
    emit(
      FollowStateChanged(
        isFollow: isFollow,
        publisherId: publisherId ?? 0,
      ),
    );
  }

  void _toggleBlogDetailsFav({
    required BuildContext context,
    required int index,
  }) {
    // log("likeData.index ${index}");

    if (index >= 0) {
      var isLike = (_blogs![index].isLike ?? false);
      _blogs![index].isLike = !(blogs[index].isLike ?? false);
      var likeCount = _blogs?[index].likesCount ?? 0;
      // log("likeData.isLike ${isLike}");
      // log("likeData.likeCount ${likeCount}");

      if (isLike && likeCount > 0) {
        _blogs?[index].likesCount = likeCount - 1;
      } else {
        _blogs?[index].likesCount = likeCount + 1;
      }
    }
    log("likeData.status ${_blogs?[index].likesCount}");

    try {

    context.read<BlogDetailsCubit>().toggleFavBtn();
    } catch (_) {
      // TODO
    }
  }
}
