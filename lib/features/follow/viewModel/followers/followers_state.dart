part of 'followers_cubit.dart';

abstract class FollowersState extends Equatable {
  const FollowersState();

  @override
  List<Object> get props => [];
}

class FollowersInitial extends FollowersState {}

class FollowersLoading extends FollowersState {}

class FollowersError extends FollowersState {}

class FollowersDone extends FollowersState {}

class FollowStateChanged extends FollowersState {
  const FollowStateChanged({
    required this.isFollow,
    required this.userId,
  });

  final int userId;
  final bool isFollow;

  @override
  List<Object> get props => [userId, isFollow];
}
