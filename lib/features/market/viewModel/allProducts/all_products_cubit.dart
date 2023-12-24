import 'dart:developer';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/laravel_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/product_data_model.dart';
import '../../repo/all_products_repo.dart';
import '../../repo/delete_product_repo.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit({
    this.userId,
    this.productsSection,
    this.categoryId,
  }) : super(AllProductsInitial());

  ///whether we wanna get special products or new products
  final String? productsSection;

  /// products of specific category
  final int? categoryId;

  /// products of specific user
  final int? userId;

  var scrollController = ScrollController();
  int _page = 1;
  bool _hasNext = false;
  Future<void> getProducts() async {
    emit(_page > 1 ? AllProductsLoadingMore() : AllProductsLoading());
    try {
      var allProductsData = await AllProductsRepo.getProducts(
        page: _page,
        productsSection: productsSection,
        categoryId: categoryId,
        userId: userId,
      );
      print("products ${allProductsData?.data}");

      if (allProductsData == null) {
        emit(AllProductsError());
        return;
      }
      if (allProductsData.status == true) {
        if (_page > 0) {
          _products?.addAll(
            allProductsData.data!.products!.data!.map(
              (e) => e,
            ),
          );
        } else {
          _products = allProductsData.data?.products?.data;
        }
        _hasNext = (allProductsData.data?.products?.lastPage ?? 0) >
            (allProductsData.data?.products?.currentPage ?? 0);
        if (_hasNext) {
          _page++;
        }
        emit(AllProductsDone());
      } else {
        emit(AllProductsError());
      }
    } on LaravelException catch (error) {
      Fluttertoast.showToast(
        msg: error.exception,
        backgroundColor: Colors.red,
      );
      emit(AllProductsError());
    }
  }

  List<ProductDetailsData>? _products = [];
  List<ProductDetailsData> get products => [...?_products];

  initScroller() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      await Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: 'جاري تحميل المزيد من العناصر',
      );
      getProducts();
    }
  }

  void changeProductFavStatus({int? productId}) {
    var index =
        _products?.indexWhere((element) => element.id == productId) ?? -1;

    if (index >= 0) {
      var isLike = _products?[index].isLike ?? false;
      _products?[index].isLike = !isLike;
      emit(
        ProductFavStateChanged(
          productId: productId ?? 0,
          isLike: _products?[index].isLike ?? false,
        ),
      );
    }
  }

  Future<void> deleteProductById({required int? productId}) async {
    var index =
        _products?.indexWhere((element) => element.id == productId) ?? -1;
    if (index < 0) {
      return;
    }
    var product = _products?[index];
    if (product == null) {
      return;
    }
    _products?.removeAt(index);
    emit(ProductListStateChanged(productLength: _products?.length ?? 0));

    try {
      var delProductData = await DeleteProductRepo.deleteProductById(
        productId: productId,
      );
      if (delProductData == null) {
        return;
      }
      Fluttertoast.showToast(
        msg: delProductData.message ?? '',
      );
      if (delProductData.status == false) {
        _products?.insert(
          index,
          product,
        );
        emit(ProductListStateChanged(
          productLength: _products?.length ?? 0,
        ));
      }
    } catch (_) {
      Fluttertoast.showToast(
        msg: 'something_wrong'.translate,
      );
      _products?.insert(
        index,
        product,
      );
      emit(ProductListStateChanged(productLength: _products?.length ?? 0));
    }
  }

  @override
  Future<void> close() {
    log('productCubitClosed');
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    return super.close();
  }

  void modifyProduct(ProductDetailsData? product) {
    var index =
        _products?.indexWhere((element) => element.id == product?.id) ?? -1;

    if (index < 0) {
      _products?.insert(0, product!);
    } else {
      _products?[index] = product!;
    }
    emit(AllProductsInitial());
    emit(ProductListStateChanged(productLength: _products?.length ?? 0));
  }
}
