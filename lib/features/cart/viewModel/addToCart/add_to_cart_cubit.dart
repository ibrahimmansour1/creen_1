import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/features/cart/viewModel/cart/cart_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';
import '../../repo/add_to_cart_repo.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());

  Future<void> addToCart(
    BuildContext context, {
    @required int? productId,
    int quantity = 1,
  }) async {
    emit(AddToCartLoading(productId: productId ?? 0));
    var cartCubit = context.read<CartCubit>();
    try {
      var addToCartData = await AddToCartRepo.addToCart(
        context,
        body: {
          'product_id': productId,
          'quantity': quantity,
        },
      );
      if (addToCartData == null) {
        Fluttertoast.showToast(
          msg: 'يرجى التحقق من الاتصال بالانترنت',
        );

        return;
      }
      Fluttertoast.showToast(
        msg: addToCartData.message ?? '',
      );
      cartCubit.getMyCart();
      emit(AddToCartDone());
    } on LaravelException catch (error) {
      Fluttertoast.showToast(
        msg: error.exception,
      );
      emit(AddToCartError());
    }
  }
}
