import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import '../../model/products_categories_model.dart';
import '../../repo/products_categories_repo.dart';

part 'products_categories_state.dart';

class ProductsCategoriesCubit extends Cubit<ProductsCategoriesState> {
  ProductsCategoriesCubit() : super(ProductsCategoriesInitial());

  var scrollController = ScrollController();
  var _hasNext = false;
  var _page = 1;
  List<ProductsCategory>? _categories = [];
  List<ProductsCategory> get productCategories => [...?_categories];
  List<ProductsCategory> productSubCategoriesByCatId({required int? catId}) => [
        ...?_categories
            ?.firstWhere((element) => element.id == catId,
                orElse: () => ProductsCategory())
            .children,
      ];

  void initListeners() => scrollController.addListener(_onScroll);

  void _onScroll() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {}
  }

  Future<void> getProductsCategories() async {
    emit(_page == 1
        ? ProductsCategoriesLoading()
        : ProductsCategoriesLoadingMore());
    try {
      var productCatData = await ProductsCategoriesRepo.getProductsCategories(
        page: _page,
      );
      if (productCatData == null) {
        emit(ProductsCategoriesError());
        return;
      }
      if (productCatData.status == true) {
        if (_page > 1) {
          _categories
              ?.addAll(productCatData.data!.categories!.data!.map((e) => e));
        } else {
          _categories = productCatData.data?.categories?.data;
        }
        _hasNext = productCatData.data?.categories?.nextPageUrl != null;
        if (_hasNext) {
          _page++;
        }
      }
      emit(ProductsCategoriesDone());
    } catch (e) {
      emit(ProductsCategoriesError());
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
