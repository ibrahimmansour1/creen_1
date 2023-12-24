part of 'blogs_cubit.dart';

abstract class BlogsState extends Equatable {
  const BlogsState();

  @override
  List<Object> get props => [];
}

class BlogsInitial extends BlogsState {}

class BlogsLoading extends BlogsState {}

class FollowStateChanged extends BlogsState {
  const FollowStateChanged({
    required this.isFollow,
    required this.publisherId,
  });
  final int publisherId;
  final bool isFollow;
  @override
  List<Object> get props => [
        isFollow,
        publisherId,
      ];
}

class DeleteBlogsLoading extends BlogsState {
  const DeleteBlogsLoading({
    required this.blogsId,
  });
  final int blogsId;

  @override
  // TODO: implement props
  List<Object> get props => [
        blogsId,
      ];
}

class RetweetBlogsLoading extends BlogsState {
  const RetweetBlogsLoading({
    required this.blogsId,
  });
  final int blogsId;

  @override
  List<Object> get props => [
        blogsId,
      ];
}

class BlogsLoadingMore extends BlogsState {}

class CommentStateChanged extends BlogsState {}

class BlogsStateChanged extends BlogsState {
  const BlogsStateChanged({
    required this.length,
  });

  final int length;

  @override
  List<Object> get props => [
        length,
      ];
}

class Done extends BlogsState {}

class Error extends BlogsState {}

class AddLikeToPostLoading extends BlogsState {
  final int postId;

  const AddLikeToPostLoading({
    required this.postId,
  });

  @override
  List<Object> get props => [
        postId,
      ];
}

class FollowPublisher extends BlogsState {
  final int userId;

  const FollowPublisher({
    required this.userId,
  });

  @override
  List<Object> get props => [
        userId,
      ];
}
