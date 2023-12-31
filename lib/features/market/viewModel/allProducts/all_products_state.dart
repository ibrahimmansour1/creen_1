part of 'all_products_cubit.dart';

abstract class AllProductsState extends Equatable {
  const AllProductsState();

  @override
  List<Object> get props => [];
}

class AllProductsInitial extends AllProductsState {}

class ProductListStateChanged extends AllProductsState {
  const ProductListStateChanged({
    required this.productLength,
  });
  final int productLength;

  @override
  List<Object> get props => [
        productLength,
      ];
}

class AllProductsLoading extends AllProductsState {}

class AllProductsLoadingMore extends AllProductsState {}

class AllProductsDone extends AllProductsState {}

class AllProductsError extends AllProductsState {}

class ProductFavStateChanged extends AllProductsState {
  const ProductFavStateChanged({
    required this.productId,
    required this.isLike,
  });
  final int productId;
  final bool isLike;
  @override
  // TODO: implement props
  List<Object> get props => [
        productId,
        isLike,
      ];
}
