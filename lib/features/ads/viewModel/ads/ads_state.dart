part of 'ads_cubit.dart';

abstract class AllAdsState extends Equatable {
  const AllAdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AllAdsState {}

class AdsLoading extends AllAdsState {}

class AdsLoadingMore extends AllAdsState {}

class AdsDone extends AllAdsState {}

class AdsError extends AllAdsState {}

class AdListStateChanged extends AllAdsState {
  const AdListStateChanged({
    required this.adsList,
  });
  final List<AdData> adsList;

  @override
  List<Object> get props => adsList;
}
