part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {
  const AddToCartLoading({
    required this.productId,
  });
  final int productId;
  @override
  // TODO: implement props
  List<Object> get props => [
        productId,
      ];
}

class AddToCartDone extends AddToCartState {}

class AddToCartError extends AddToCartState {}
