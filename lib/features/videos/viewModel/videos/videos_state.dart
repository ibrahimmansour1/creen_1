part of 'videos_cubit.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosInitial extends VideosState {}

class VideosLoading extends VideosState {}

class VideosLoadingMore extends VideosState {}

class VideosDone extends VideosState {}

class VideosError extends VideosState {}

class UploadingVid extends VideosState {}

class UploadingVidDone extends VideosState {}

class CommentStateChanged extends VideosState {
  const CommentStateChanged({
    required this.commentsLength,
    required this.videoId,
  });
  final int commentsLength;
  final int videoId;

  @override
  List<Object> get props => [
        videoId,
        commentsLength,
      ];
}

class VideosLikesStateChanged extends VideosState {
  const VideosLikesStateChanged({
    required this.isLike,
    required this.videoId,
  });
  final bool isLike;
  final int videoId;

  @override
  List<Object> get props => [
        isLike,
        videoId,
      ];
}
