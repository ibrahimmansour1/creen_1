part of 'points_cubit.dart';

abstract class PointsState extends Equatable {
  const PointsState();

  @override
  List<Object> get props => [];
}

class PointsInitial extends PointsState {}

class PointsLoading extends PointsState {}

class PointsLoadingMore extends PointsState {}

class PointsDone extends PointsState {}

class PointsError extends PointsState {}

class TransferPointsLoading extends PointsState {}
