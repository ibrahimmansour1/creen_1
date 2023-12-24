import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/features/ads/repo/delete_ad_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/ad_data.dart';
import '../../repo/all_ads_repo.dart';

part 'ads_state.dart';

class AllAdsCubit extends Cubit<AllAdsState> {
  AllAdsCubit({
    this.categoryId,
    this.userId,
  }) : super(AdsInitial());
  final int? userId, categoryId;

  List<AdData>? _ads = [];
  List<AdData> get ads => [...?_ads];
  bool get isMyAds => userId == HelperFunctions.currentUser?.id;
  var scrollController = ScrollController();
  var _page = 1;
  var _hasNext = false;

  void initController() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getAllAds();
    }
  }

  Future<void> getAllAds() async {
    emit(_page > 1 ? AdsLoadingMore() : AdsLoading());
    try {
      var allAdsData = await AllAdsRepo.getAllAds(
        userId: userId,
        categoryId: categoryId,
      );
      if (allAdsData == null) {
        emit(AdsError());
        return;
      }
      if (allAdsData.status == true) {
        if (_page > 1) {
          _ads?.addAll(allAdsData.data!.data!.map((e) => e));
        } else {
          _ads = allAdsData.data?.data;
        }
        _hasNext = (allAdsData.data?.lastPage ?? 0) >
            (allAdsData.data?.currentPage ?? 0);
        if (_hasNext) {
          _page++;
        }
      }
      emit(AdsDone());
    } catch (e) {
      emit(AdsError());
    }
  }

  Future<void> deleteAdById({
    required int? adId,
  }) async {
    var index = _ads?.indexWhere((element) => element.id == adId) ?? -1;
    if (index < 0) {
      return;
    }
    var ad = _ads?[index];
    if (ad == null) {
      return;
    }
    _ads?.removeAt(index);
    emit(AdListStateChanged(adsList: _ads ?? []));

    try {
      var allAdsData = await DeleteAdRepo.deleteAds(
        adId: adId ?? 0,
      );
      if (allAdsData == null) {
        emit(AdsError());
        return;
      }
      if (allAdsData.status == false) {
        _ads?.insert(index, ad);
        emit(AdListStateChanged(adsList: _ads ?? []));
      }
      emit(AdsDone());
    } catch (e) {
      emit(AdsError());
    }
  }

  void modifyAd({AdData? adData}) {
    if (adData == null) {
      return;
    }
    var index = _ads?.indexWhere((element) => element.id == adData.id) ?? -1;
    if (index >= 0) {
      _ads?[index] = adData;
    } else {
      _ads?.insert(0, adData);
    }
    emit(AdListStateChanged(adsList: _ads ?? []));
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
