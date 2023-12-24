import 'dart:developer';
import 'dart:io';

import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/market/repo/create_product_repo.dart';
import 'package:creen/features/market/viewModel/allProducts/all_products_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/product_data_model.dart';

part 'add_new_product_state.dart';

class AddNewProductCubit extends Cubit<AddNewProductState> {
  AddNewProductCubit({
    this.product,
  }) : super(AddNewProductInitial()) {
    if (product != null) {
      subCatId = product?.categoryId;
      nameController.text = product?.title ?? '';
      priceController.text = product?.price?.toString() ?? '';
      descController.text = product?.description ?? '';
      shippingPriceController.text =
          product?.details?.shippingPrice?.toString() ?? '';
      mainCatId = product?.categoryParentId;
      subCatId = product?.categoryId;
      linkVideoController.text = product?.details?.video ?? '';
      hiddenDataController.text = product?.details?.hiddenData ?? '';
      whatsappController.text = product?.details?.whatsapp ?? '';
      paymentMethod = product?.details?.payment ?? '';
      productStatus = product?.details?.status ?? '';
      qty = product?.details?.quantity ?? 0;
    }
  }
  final ProductDetailsData? product;

  int? mainCatId, subCatId;
  int qty = 1;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var shippingPriceController = TextEditingController();
  var descController = TextEditingController();
  var linkVideoController = TextEditingController();
  var hiddenDataController = TextEditingController();
  var weightController = TextEditingController();
  var colorController = TextEditingController();
  var sizesController = TextEditingController();
  var whatsappController = TextEditingController();

  List<File> images = [];
  String? paymentMethod, productStatus;

  final paymentTypes = [
    'when recieving',
    'bank transfer',
  ];
  final status = [
    'new',
    'used',
  ];

  List<String> colors = [], sizes = [];
  void onMainCatChanged(int? value) {
    if (value == null) {
      return;
    }
    mainCatId = value;
    subCatId = null;
    log('$subCatId');
    emit(MainCatIdStateChanged(mainCatId: value));
  }

  void onSubCatChanged(int? value) {
    if (value == null) {
      return;
    }
    log('$value', name: 'sub_cat');
    subCatId = value;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    priceController.dispose();
    shippingPriceController.dispose();
    descController.dispose();
    linkVideoController.dispose();
    hiddenDataController.dispose();

    return super.close();
  }

  void onColorSubmitted(String value) {
    if (value.isEmpty) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    colors.add(value);
    colorController.clear();
    emit(ColorListStateChanged(
      colorLength: colors.length,
    ));
  }

  void onSizesSubmitted(String value) {
    if (value.isEmpty) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    sizes.add(value);
    sizesController.clear();
    emit(SizesListStateChanged(
      sizesLength: sizes.length,
    ));
  }

  void deleteColorByIndex(int index) {
    colors.removeAt(index);
    emit(ColorListStateChanged(
      colorLength: colors.length,
    ));
  }

  void deleteSizeByIndex(int index) {
    sizes.removeAt(index);
    emit(SizesListStateChanged(
      sizesLength: sizes.length,
    ));
  }

  void onPaymentMethod(String? value) {
    if (value == null) {
      return;
    }
    paymentMethod = value;
  }

  void onStatusMethod(String? value) {
    if (value == null) {
      return;
    }
    productStatus = value;
  }

  void onQTYChanged(int value) {
    qty = value;
  }

  void onImagePicked() async {
    var pickedImages = await HelperFunctions.selectImages(
      imageCount: 5,
      showCamera: true,
    );
    if (pickedImages.isEmpty) {
      return;
    }
    images.addAll(pickedImages.map((e) => e));
    emit(ImagesListStateChanged(imageLength: images.length));
  }

  void deleteImageByIndex(int imageIndex) {
    images.removeAt(imageIndex);
    emit(ImagesListStateChanged(imageLength: images.length));
  }

  Future<void> createNewProduct({
    required BuildContext context,
  }) async {
    emit(AddNewProductLoading());

    try {
      FocusManager.instance.primaryFocus?.unfocus();
      var productsCubit = context.read<AllProductsCubit>();
      var isEdit = product != null;
      var createNewProductData = await CreateProductRepo.createProducts(
        isEdit: isEdit,
        body: {
          if (isEdit) ...{
            'product_id': product?.id,
          },
          'category': subCatId,
          'name': nameController.text,
          'price': priceController.text,
          'description': descController.text,
          'colors[]': colors,
          'sizes[]': sizes,
          'quantity': qty,
          'weight': weightController.text,
          'status': productStatus,
          'payment': paymentMethod,
          'whatsapp': whatsappController.text,
          'shipping_price': shippingPriceController.text,
          'hidden_data': hiddenDataController.text,
          'video': linkVideoController.text,
          for (int i = 0; i < images.length; i++)
            'images[$i]': await MultipartFile.fromFile(images[i].path),
        },
      );
      emit(AddNewProductDone());
      if (createNewProductData == null) {
        return;
      }
      Fluttertoast.showToast(
        msg: createNewProductData.message ?? '',
      );
      if (createNewProductData.status == true) {
        productsCubit.modifyProduct(createNewProductData.data);
        NavigationService.goBack();
      }
    } catch (_) {
      emit(AddNewProductDone());
    }
  }

  void incrementQty() {
    qty++;
    emit(QtyStateChanged(qty: qty));
  }

  void decrementQty() {
    qty--;
    emit(QtyStateChanged(qty: qty));
  }
}
