part of 'following_cubit.dart';

abstract class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object> get props => [];
}

class FollowingInitial extends FollowingState {}

class FollowingLoading extends FollowingState {}

class FollowingDone extends FollowingState {}

class FollowingError extends FollowingState {}
