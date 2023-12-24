part of 'products_categories_cubit.dart';

abstract class ProductsCategoriesState extends Equatable {
  const ProductsCategoriesState();

  @override
  List<Object> get props => [];
}

class ProductsCategoriesInitial extends ProductsCategoriesState {}

class ProductsCategoriesLoading extends ProductsCategoriesState {}

class ProductsCategoriesLoadingMore extends ProductsCategoriesState {}

class ProductsCategoriesDone extends ProductsCategoriesState {}

class ProductsCategoriesError extends ProductsCategoriesState {}
