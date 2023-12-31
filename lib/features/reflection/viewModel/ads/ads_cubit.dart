import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/utils/laravel_exception.dart';
import '../../model/ads_model.dart';
import '../../repo/ads_repo.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial());

  Future<void> getAds() async {
    emit(AdsLoading());
    try {
      var adsData = await AdsRepo.getAds();

      if (adsData == null) {
        emit(AdsError());
        return;
      }
      if (adsData.status == true) {
        _ads = adsData.data;
        emit(AdsDone());
      } else {
        emit(AdsError());
      }
    } on LaravelException catch (error) {
      emit(AdsError());
      Fluttertoast.showToast(msg: error.exception);
    }
  }

  List<Ads>? _ads = [];
  List<Ads> get ads => [...?_ads];
}
