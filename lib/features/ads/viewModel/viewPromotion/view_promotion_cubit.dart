import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/view_promotion_model.dart';
import '../../repo/view_promotion_repo.dart';

part 'view_promotion_state.dart';

class ViewPromotionCubit extends Cubit<ViewPromotionState> {
  ViewPromotionCubit({
    required this.promotionId,
  }) : super(ViewPromotionInitial());
  final int? promotionId;

  PromotionData? _promotionData;
  PromotionData? get promotionData => _promotionData;

  Future<void> viewPromotion() async {
    emit(ViewPromotionLoading());
    try {
      var viewPromotionData =
          await ViewPromotionRepo.viewPromotion(promotionId: promotionId);
      if (viewPromotionData == null) {
        emit(ViewPromotionError());
        return;
      }
      if (viewPromotionData.status == true) {
        _promotionData = viewPromotionData.data;
      }
      emit(ViewPromotionDone());
    } catch (_) {
      emit(ViewPromotionError());
    }
  }
}
