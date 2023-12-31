import 'dart:io';

import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/chat/model/stories_model.dart';
import 'package:creen/features/chat/repo/delete_story_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/create_new_story_repo.dart';
import '../../repo/stories_repo.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit() : super(StoriesInitial());
  List<StoryPublisher>? _stories = [];
  List<StoryPublisher> get stories =>
      [...?_stories?.where((element) => element.story?.isNotEmpty == true)];
  int storyBySpecificUser({required int userId}) {
    var userStoryIndex =
        _stories?.indexWhere((element) => element.id == userId) ?? -1;

    return userStoryIndex;
  }

  var scrollController = ScrollController();
  var _page = 1;
  var _hasNext = false;

  void initListener() => scrollController.addListener(_onScroll);

  void _onScroll() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getStories();
    }
  }

  Future<void> getStories() async {
    emit(_page > 1 ? StoriesLoadingMore() : StoriesLoading());
    try {
      var storiesData = await StoriesRepo.getStories(page: _page);

      if (storiesData == null) {
        emit(StoriesError());
        return;
      }
      if (storiesData.status == true) {
        if (_page > 1) {
          _stories?.addAll(storiesData.data!.stories!.data!.map((e) => e));

        } else {
          _stories = storiesData.data!.stories!.data;
        }
        _hasNext = storiesData.data!.stories!.nextPageUrl != null;
        if (_hasNext) {
          _page++;
        }
      }
      emit(StoriesDone());
    } catch (_) {
      emit(StoriesError());
    }
  }

  Future<void> createNewStory({
    required File? image,
    required String? description,
    required String? background,
    required String? fontSize,
    required String? fontFamily,
    required String? fontColor,
    required String? fontWeight,
    required String? fontBorderColor,
    required String? align,
    required String? outline,
    required String? record,
    required File? video,
  }) async {
    emit(CreateNewStoryLoading());
    try {
      // print("storiesData ${888888888888888888}");
      // print("image ${image}");

      var storiesData = await CreateNewStoryRepo.createNewStory(
          body: {
            if(image != null)
        'image': await MultipartFile.fromFile(image.path),
        'text': description,
        'record': record,
            if(video != null)'video': await MultipartFile.fromFile(video.path),
        'background': background,
        'font_size': fontSize,
        'font_family': fontFamily,
        'font_color': fontColor,
        'font_weight': fontWeight,
        'align': align,
        'outline': outline,
        'font_border_color': fontBorderColor,
      }..removeWhere((key, value) => value == null));
print("storiesData ${storiesData}");
      if (storiesData == null) {
        emit(StoriesError());
        return;
      }
      if (storiesData.status == true) {
        var index = _stories?.indexWhere(
                (element) => element.id == HelperFunctions.currentUser?.id) ??
            -1;
        if (index >= 0) {
          _stories?[index].story?.add(storiesData.data!);
        } else {
          var user = HelperFunctions.currentUser;
          _stories?.add(
            StoryPublisher(
              about: user?.about,
              address: user?.address,
              age: user?.age,
              cityId: user?.cityId,
              countryId: user?.countryId,
              cover: user?.cover,
              email: user?.email,
              gender: user?.gender,
              id: user?.id,
              name: user?.name,
              profile: user?.profile,
              story: [
                storiesData.data!,
              ],
            ),
          );
        }
      }
      emit(StoriesDone());
    } catch (_) {
      emit(StoriesError());
    }
  }

  Future<void> deleteStoryByIndex({
    required int pageIndex,
    required int userId,
    required int storyIndex,
    required BuildContext context,
  }) async {
    // var userId = HelperFunctions.currentUser?.id;
    // var storyIndex =
    //     _stories?.indexWhere((element) => element.id == userId) ?? -1;
    // if (storyIndex < 0) {
    //   return;
    // }
    var navigator = Navigator.of(context);
    var story = _stories?[pageIndex].story?[storyIndex];

    navigator.pop();
    navigator.pop();
    _stories?[pageIndex].story?.removeAt(storyIndex);
    emit(StoriesStateChanged(
      length: _stories?[pageIndex].story?.length ?? 0,
      userId: userId,
    ));

    try {
      var deleteStoryData = await DeleteStoryRepo.deleteStory(
        storyId: story?.id ?? 0,
      );
      if (deleteStoryData == null || deleteStoryData.status == false) {
        _stories?[pageIndex].story?.insert(
              storyIndex,
              story!,
            );
        emit(StoriesStateChanged(
          length: _stories?[pageIndex].story?.length ?? 0,
          userId: userId,
        ));
      }
    } catch (_) {
      _stories?[pageIndex].story?.insert(
            storyIndex,
            story!,
          );
      emit(StoriesStateChanged(
        length: _stories?[pageIndex].story?.length ?? 0,
        userId: userId,
      ));
    }
  }

  void changeFollowStatus({int? publisherId}) {
    var pageIndex =
        _stories?.indexWhere((element) => element.id == publisherId) ?? -1;
    if (pageIndex < 0) {
      return;
    }
    _stories?[pageIndex].isFollow = !(_stories?[pageIndex].isFollow ?? false);

    emit(StoriesPublisherFollowStateChanged(
        isFollow: _stories?[pageIndex].isFollow ?? false,
        userId: publisherId ?? 0));
  }
}
