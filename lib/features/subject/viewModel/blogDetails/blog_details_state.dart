part of 'blog_details_cubit.dart';

abstract class BlogDetailsState extends Equatable {
  const BlogDetailsState();

  @override
  List<Object> get props => [];
}

class BlogDetailsInitial extends BlogDetailsState {}

class BlogDetailsLoading extends BlogDetailsState {}

class BlogDetailsDone extends BlogDetailsState {}

class BlogDetailsError extends BlogDetailsState {}

class BlogFollowStateChanged extends BlogDetailsState {
  const BlogFollowStateChanged({
    required this.isFollow,
  });
  final bool isFollow;
  @override
  // TODO: implement props
  List<Object> get props => [
        isFollow,
      ];
}

class BlogFavStateChanged extends BlogDetailsState {
  const BlogFavStateChanged({
    required this.isFav,
  });
  final bool isFav;
  @override
  List<Object> get props => [isFav];
}

class BlogRetweetStateChanged extends BlogDetailsState {
  const BlogRetweetStateChanged({
    required this.length,
  });
  final int length;
  @override
  List<Object> get props => [length];
}

class BlogCommentStateChanged extends BlogDetailsState {
  const BlogCommentStateChanged({
    required this.length,
  });
  final int length;
  @override
  List<Object> get props => [length];
}
