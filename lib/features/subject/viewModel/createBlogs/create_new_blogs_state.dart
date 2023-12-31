part of 'create_new_blogs_cubit.dart';

abstract class CreateNewBlogsState extends Equatable {
  const CreateNewBlogsState();

  @override
  List<Object> get props => [];
}

class CreateNewBlogsInitial extends CreateNewBlogsState {}

class CreateNewBlogsLoading extends CreateNewBlogsState {}

class CreateNewBlogsDone extends CreateNewBlogsState {}

class CreateNewBlogsError extends CreateNewBlogsState {}

class ImagesListStateChanged extends CreateNewBlogsState {
  const ImagesListStateChanged({
    required this.length,
  });
  final int length;
  @override
  List<Object> get props => [
        length,
      ];
}
