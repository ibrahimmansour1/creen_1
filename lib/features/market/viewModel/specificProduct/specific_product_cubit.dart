import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/specific_product_model.dart';
import '../../repo/specific_product_view_repo.dart';

part 'specific_product_state.dart';

class SpecificProductCubit extends Cubit<SpecificProductState> {
  SpecificProductCubit({
    this.productId,
  }) : super(SpecificProductInitial());
  final int? productId;
  int carsoulSliderIndex = 0;

  Future<void> viewProduct() async {
    if (productId == null) {
      return;
    }
    emit(SpecificProductLoading());
    try {
      var viewProductData = await SpecificProductRepo.viewProduct(
        productId: productId,
      );

      if (viewProductData == null) {
        emit(SpecificProductError());
        return;
      }
      if (viewProductData.status == true) {
        _productData = viewProductData.data;
        emit(SpecificProductDone());
      } else {
        emit(SpecificProductError());
      }
    } catch (error) {
      emit(SpecificProductError());
    }
  }

  void changeProductFavStatus() {
    log('fav is before ${_productData?.isLike}');
    _productData?.isLike = !(_productData?.isLike ?? false);
    log('fav is after ${_productData?.isLike}');
    emit(
      SpecificProductFavStateChanged(
        isFav: _productData?.isLike ?? false,
      ),
    );
  }

  Future<void> deleteComment() async {}

  void updateIndex({required int index}) {
    carsoulSliderIndex = index + 1;
    log('carsoulSliderIndex value $carsoulSliderIndex');
    emit(SpecificProductIndexUpdate(index: carsoulSliderIndex));
    // emit(SpecificProductIndexUpdate(index: carsoulSliderIndex));
    emit(SpecificProductDone());
  }

  ProductData? _productData;

  ProductData? get productData => _productData;
}
