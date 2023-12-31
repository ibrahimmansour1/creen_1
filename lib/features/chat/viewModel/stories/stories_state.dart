part of 'stories_cubit.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();

  @override
  List<Object> get props => [];
}

class StoriesInitial extends StoriesState {}

class StoriesLoading extends StoriesState {}

class CreateNewStoryLoading extends StoriesState {}

class StoriesLoadingMore extends StoriesState {}

class StoriesDone extends StoriesState {}

class StoriesError extends StoriesState {}

class StoriesStateChanged extends StoriesState {
  const StoriesStateChanged({
    required this.length,
    required this.userId,
  });
  final int length, userId;

  @override
  List<Object> get props => [
        length,
        userId,
      ];
}

class StoriesPublisherFollowStateChanged extends StoriesState {
  const StoriesPublisherFollowStateChanged({
    required this.isFollow,
    required this.userId,
  });
  final bool isFollow;
  final int userId;

  @override
  List<Object> get props => [
        isFollow,
        userId,
      ];
}
