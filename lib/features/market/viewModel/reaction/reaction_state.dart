part of 'reaction_cubit.dart';

abstract class ReactionState extends Equatable {
  const ReactionState();

  @override
  List<Object> get props => [];
}

class ReactionInitial extends ReactionState {}

class ReactionLoading extends ReactionState {}

class ReactionDone extends ReactionState {}

class ReactionError extends ReactionState {}
