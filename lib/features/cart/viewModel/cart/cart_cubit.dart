import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/my_cart_model.dart';
import '../../repo/my_cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<Cart>? _carts = [];
  List<Cart> get carts => [...?_carts];

  bool containsProduct({required int? productId}) =>
      (_carts?.indexWhere((e) => e.productId == productId) ?? 0) >= 0;

  Future<void> getMyCart() async {
    emit(CartLoading());

    try {
      var cartData = await MyCartRepo.myCart();
      if (cartData == null) {
        emit(CartError());
        return;
      }
      if (cartData.status == true) {
        _carts = cartData.data?.carts;
        emit(CartDone());
      } else {
        emit(CartError());
      }
    } catch (_) {
      emit(CartError());
    }
  }
}
