import 'dart:developer';

import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/subject/model/blogs_model.dart';
import 'package:creen/features/videos/repo/add_comment_to_video_repo.dart';
import 'package:creen/features/videos/repo/add_video_repo.dart';
import 'package:creen/features/videos/repo/remove_video.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_pickers/image_pickers.dart';

import '../../model/videos_model.dart';
import '../../presentaion/pages/video_confirm_screen.dart';
import '../../repo/react_video_repo.dart';
import '../../repo/videos_repo.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  var commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  VideosCubit({
    this.userId,
  }) : super(VideosInitial()) {
    log('constructor of vidCubit');
    if (userId != null) {
      myVidScrollController = ScrollController();
    } else {
      scrollController = PageController(initialPage: 0, viewportFraction: 1);
    }
  }

  void initPageControllerToSpecificPage({
    required int index,
    required BuildContext context,
  }) {
    scrollController = PageController(initialPage: index, viewportFraction: 1);
    initController(context);
  }

  final int? userId;

  PageController? scrollController;
  ScrollController? myVidScrollController;
  List<VideoData>? _videos = [];
  List<VideoData> get videos => [...?_videos];
  bool _hasNext = false;
  int _page = 1;
  Future<void> getVideos(
    context, {
    bool isInit = true,
  }) async {
    if (isInit) {
      _page = 1;
      _hasNext = false;
      _videos?.clear();
    }
    emit(
      _page > 1 ? VideosLoadingMore() : VideosLoading(),
    );

    var videosData = await VideosRepo.getVideos(
      context,
      page: _page,
      userId: userId,
    );

    if (videosData == null) {
      emit(VideosError());
      return;
    }

    if (videosData.status == true) {
      if (_page > 1) {
        _videos?.addAll(
          videosData.data!.videos!.data!.map(
            (e) => e,
          ),
        );
      } else {
        _videos = videosData.data?.videos!.data;
      }
      _hasNext = (videosData.data?.videos?.lastPage ?? 0) >
          (videosData.data?.videos?.currentPage ?? 0);
      if (_hasNext) {
        _page++;
      }
      emit(VideosDone());
    } else {
      emit(VideosError());
    }
  }

  initController(context) =>
      scrollController?.addListener(() => _onScroll(context));
  initMyController(context) =>
      myVidScrollController?.addListener(() => _onVidScroll(context));

  bool isLikeVideo({required int index}) =>
      (_videos?[index].likes?.indexWhere((element) =>
              element.user?.id == HelperFunctions.currentUser?.id) ??
          -1) >=
      0;

  Future<void> addLikeToVideo({required int? videoId}) async {
    var index = _videos?.indexWhere((element) => element.id == videoId) ?? -1;
    var currentUser = HelperFunctions.currentUser;
    var likeIndex = _videos?[index].likes?.indexWhere((element) {
          return element.user?.id == currentUser?.id;
        }) ??
        -1;

    bool isLike = likeIndex >= 0;
    if (isLike) {
      _videos?[index].likes?.removeWhere(
            (element) => element.user?.id == currentUser?.id,
          );
    } else {
      _videos?[index].likes?.add(
            Like(
              user: HelperFunctions.currentUser,
            ),
          );
    }
    // likeIndex = _videos?[index].likes?.indexWhere(
    //         (element) => element.userId == HelperFunctions.currentUser?.id) ??
    //     -1;
    // isLike = likeIndex >= 0;
    emit(VideosLikesStateChanged(
      isLike: isLike,
      videoId: videoId ?? 0,
    ));

    var reactData = await VideoReactionRepo.react(
      isLike: isLike,
      videoId: videoId,
    );
    if (reactData == null || reactData.status == false) {
      _videos?[index].likes?.removeWhere(
            (element) => element.user?.id == HelperFunctions.currentUser?.id,
          );
      emit(VideosLikesStateChanged(
        isLike: isLike,
        videoId: videoId ?? 0,
      ));
    }
  }

  @override
  Future<void> close() {
    scrollController?.dispose();
    myVidScrollController?.dispose();
    return super.close();
  }

  _onScroll(context) async {
    var outOfRange2 = scrollController?.position.outOfRange ?? false;
    var maxScrollExtent2 = scrollController?.position.maxScrollExtent ?? 0;
    if (_hasNext &&
        (scrollController?.offset ?? 0) >= maxScrollExtent2 &&
        !outOfRange2) {
      Fluttertoast.showToast(
        msg: 'جاري تحميل المزيد من العناصر',
      );
      getVideos(
        context,
        isInit: false,
      );
    }
  }

  Future<void> addCommentToVideo({
    required BuildContext context,
    int? videoId,
    required int index,
  }) async {
    if (commentController.text.isEmpty) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      var addComment =
          await AddCommentToVideoRepo.addCommentToVid(context, body: {
        'video_id': videoId,
        'comment': commentController.text,
      });

      if (addComment == null) {
        return;
      }
      if (addComment.status == true) {
        var comment = addComment.data;

        _videos?[index].comments?.add(
              Comment(
                comment: comment?.comment,
                createdAt: comment?.createdAt,
                id: comment?.id,
                liveId: comment?.liveId,
                postId: comment?.postId,
                userId: comment?.userId,
                updatedAt: comment?.updatedAt,
                timeAgo: comment?.timeAgo,
                user: HelperFunctions.currentUser,
              ),
            );
        commentController.text = "";
        emit(CommentStateChanged(
          commentsLength: _videos?[index].comments?.length ?? 0,
          videoId: videoId ?? 0,
        ));
      }
    } catch(e){
      return;
    }
  }

  Future<void> addNewVideo() async {
    var pickedVid = await HelperFunctions.selectImages(
      galleryMode: GalleryMode.video,
      imageCount: 1,
      showCamera: true,
    );

    if (pickedVid.isEmpty) {
      return;
    }

    var push = await NavigationService.push(
      page: VideoConfirmScreen(
        pickedVid: pickedVid.first,
      ),
    );
    FocusManager.instance.primaryFocus?.unfocus();
    log('type = ${push.runtimeType}');
    if (push.runtimeType != String) {
      return;
    }
    emit(UploadingVid());
    try {
      log('bef');
      var videoData = await NewVideoRepo.addNewVideo(
        body: {
          'video': await MultipartFile.fromFile(pickedVid.first.path),
          'description': push.toString(),
        },
      );
      log('aft');
      if (videoData == null) {
        emit(VideosError());
        return;
      }
      var data = videoData.data
        ?..comments = []
        ..user = HelperFunctions.currentUser;
      if (videoData.status == true) {
        _videos?.insert(
          0,
          data!,
        );
        scrollController
            ?.jumpTo((scrollController?.position.minScrollExtent ?? 0));
        emit(UploadingVidDone());
      }
    } catch (e) {
      log('error $e');
    }
  }
  Future<void> removeVideo(BuildContext ctx) async {
    try {
      var videoData = await RemoveVideoRepo.removeVideo(
       ctx, body: {
          // 'video_id':,

        },
      );
      log('aft');
      if (videoData == null) {
        emit(VideosError());
        return;
      }
      var data = videoData.data
        ?..comments = []
        ..user = HelperFunctions.currentUser;
      if (videoData.status == true) {
        _videos?.insert(
          0,
          data!,
        );
        scrollController
            ?.jumpTo((scrollController?.position.minScrollExtent ?? 0));
        emit(UploadingVidDone());
      }
    } catch (e) {
      log('error $e');
    }
  }

  _onVidScroll(context) {
    var outOfRange2 = myVidScrollController?.position.outOfRange ?? false;
    var maxScrollExtent2 = myVidScrollController?.position.maxScrollExtent ?? 0;
    if (_hasNext &&
        (myVidScrollController?.offset ?? 0) >= maxScrollExtent2 &&
        !outOfRange2) {
      Fluttertoast.showToast(
        msg: 'جاري تحميل المزيد من العناصر',
      );
      getVideos(
        context,
        isInit: false,
      );
    }
  }
}

