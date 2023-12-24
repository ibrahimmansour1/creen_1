part of 'follow_cubit.dart';

abstract class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object> get props => [];
}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {
  final int userId;

  const FollowLoading({
    required this.userId,
  });

  @override
  List<Object> get props => [
        userId,
      ];
}

class FollowDone extends FollowState {}

class FollowError extends FollowState {}
