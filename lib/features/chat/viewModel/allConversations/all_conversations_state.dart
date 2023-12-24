part of 'all_conversations_cubit.dart';

abstract class AllConversationsState extends Equatable {
  const AllConversationsState();

  @override
  List<Object> get props => [];
}

class AllConversationsInitial extends AllConversationsState {}

class AllConversationsLoading extends AllConversationsState {}

class CreateTeamLoading extends AllConversationsState {}

class CreateTeamDone extends AllConversationsState {}

class AllConversationsLoadingMore extends AllConversationsState {}

class AllConversationsDone extends AllConversationsState {}

class AllConversationsError extends AllConversationsState {}
