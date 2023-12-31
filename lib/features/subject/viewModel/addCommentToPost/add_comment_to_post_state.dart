part of 'add_comment_to_post_cubit.dart';

abstract class AddCommentToPostState extends Equatable {
  const AddCommentToPostState();

  @override
  List<Object> get props => [];
}

class AddCommentToPostInitial extends AddCommentToPostState {}

class AddCommentToPostLoading extends AddCommentToPostState {}

class AddCommentToPostDone extends AddCommentToPostState {}

class AddCommentToPostError extends AddCommentToPostState {}
