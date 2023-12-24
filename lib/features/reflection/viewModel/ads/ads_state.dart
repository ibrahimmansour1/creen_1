part of 'ads_cubit.dart';

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AdsState {}

class AdsLoading extends AdsState {}

class AdsDone extends AdsState {}

class AdsError extends AdsState {}
