import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/camera_btn.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/features/ads/view/widgets/ads_item.dart';
import 'package:creen/features/market/viewModel/addNewProduct/add_new_product_cubit.dart';
import 'package:creen/features/market/viewModel/productsCategories/products_categories_cubit.dart';
import 'package:creen/features/products/presentaion/widgets/product_item.dart';
import 'package:creen/features/products/presentaion/widgets/quentity_item.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/custom_image.dart';
import '../../../../core/utils/widgets/loader_widget.dart';

//final valueProvider1 = StateProvider((ref) => '');

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? value;

  final items = [
    'ads_advertise'.translate,
    'good_advertisment'.translate,
    'service_ads'.translate,
  ];

  late AddNewProductCubit addNewProductCubit;
  late ProductsCategoriesCubit productsCategoriesCubit;

  @override
  void initState() {
    addNewProductCubit = context.read<AddNewProductCubit>();
    productsCategoriesCubit = context.read<ProductsCategoriesCubit>()
      ..getProductsCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String value1 = ref.watch(valueProvider1);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'new_product_add',
          )),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.black45],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                tileMode: TileMode.clamp)),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Sizes.screenWidth() * 0.15,
                  ),
                  BlocBuilder<ProductsCategoriesCubit, ProductsCategoriesState>(
                    builder: (context, state) {
                      if (state is ProductsCategoriesLoading) {
                        return const Center(child: LoaderWidget());
                      }
                      return Column(
                        children: [
                          AdsItem(
                            text: 'main_department',
                            isMessage: true,
                            // content: '',
                            widget: Directionality(
                              textDirection: TextDirection.rtl,
                              child: DropdownButtonFormField<int?>(
                                value: addNewProductCubit.mainCatId,

                                // value: value,
                                items: List.generate(
                                  productsCategoriesCubit
                                      .productCategories.length,
                                  (index) {
                                    var category = productsCategoriesCubit
                                        .productCategories[index];
                                    return DropdownMenuItem<int?>(
                                      value: category.id,
                                      child: Text(
                                        category.name ?? '',
                                      ),
                                    );
                                  },
                                ),
                                onChanged: addNewProductCubit.onMainCatChanged,
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                hint:  Text('main_department'.translate),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          BlocBuilder<AddNewProductCubit, AddNewProductState>(
                            builder: (context, state) {
                              return AdsItem(
                                key: ValueKey(addNewProductCubit.mainCatId),
                                text: 'branch_department',
                                isMessage: true,
                                // content: '',
                                widget: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButtonFormField<int?>(
                                    value: addNewProductCubit.subCatId,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    // value: value,
                                    items: List.generate(
                                      productsCategoriesCubit
                                          .productSubCategoriesByCatId(
                                              catId:
                                                  addNewProductCubit.mainCatId)
                                          .length,
                                      (index) {
                                        var category = productsCategoriesCubit
                                            .productSubCategoriesByCatId(
                                                catId: addNewProductCubit
                                                    .mainCatId)[index];
                                        return DropdownMenuItem<int?>(
                                          value: category.id,
                                          child: Text(
                                            category.name ?? '',
                                          ),
                                        );
                                      },
                                    ),
                                    onChanged:
                                        addNewProductCubit.onSubCatChanged,
                                    isExpanded: true,
                                    icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                    hint:  Text('branch_department'.translate),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  AdsItem(
                    text: 'name',
                    controller: addNewProductCubit.nameController,
                    isMessage: false,
                    onChanged: (v) {},
                    // content: '',
                  ),
                  AdsItem(
                    text: 'price',
                    controller: addNewProductCubit.priceController,
                    isMessage: false,
                    onChanged: (v) {},
                    keyboardType: TextInputType.phone,
                    // content: '',
                  ),
                  AdsItem(
                    text: 'whats',
                    controller: addNewProductCubit.whatsappController,
                    keyboardType: TextInputType.phone,
                    isMessage: false,
                    onChanged: (v) {},
                    // content: '',
                  ),
                  AdsItem(
                    text: 'description',
                    controller: addNewProductCubit.descController,
                    isMessage: true,
                    onChanged: (v) {},
                    // content: '',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: CameraButton(
                      width: Sizes.screenWidth() * 0.9,
                      title: 'upload_photo',
                      function: addNewProductCubit.onImagePicked,
                      radius: 25,
                      isImage: true,
                    ),
                  ),
                  BlocBuilder<AddNewProductCubit, AddNewProductState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            addNewProductCubit.images.length,
                            (index) => CustomImage(
                              pickedImage: addNewProductCubit.images[index],
                              onRemoved: () =>
                                  addNewProductCubit.deleteImageByIndex(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProductItem(
                    controller: addNewProductCubit.colorController,
                    text: 'color',
                    onTap: () => addNewProductCubit.onColorSubmitted(
                        addNewProductCubit.colorController.text),
                    isMessage: false,
                    onFieldSubmitted: addNewProductCubit.onColorSubmitted,
                    onChanged: (v) {},
                    content: 'enter_product_color',
                  ),
                  BlocBuilder<AddNewProductCubit, AddNewProductState>(
                    builder: (context, state) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          addNewProductCubit.colors.length,
                          (index) => PropertyCard(
                            value: addNewProductCubit.colors[index],
                            onDelete: () =>
                                addNewProductCubit.deleteColorByIndex(index),
                          ),
                        ).toList(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ProductItem(
                    text: 'the_size',
                    isMessage: false,
                    onChanged: (v) {},
                    onFieldSubmitted: addNewProductCubit.onSizesSubmitted,
                    controller: addNewProductCubit.sizesController,
                    onTap: () => addNewProductCubit.onSizesSubmitted(
                        addNewProductCubit.sizesController.text),
                    content: 'enter_product_size',
                  ),
                  BlocBuilder<AddNewProductCubit, AddNewProductState>(
                    builder: (context, state) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        children: List.generate(
                          addNewProductCubit.sizes.length,
                          (index) => PropertyCard(
                            value: addNewProductCubit.sizes[index],
                            onDelete: () =>
                                addNewProductCubit.deleteSizeByIndex(index),
                          ),
                        ).toList(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AdsItem(
                    text: 'video_link',
                    isMessage: false,
                    onChanged: (v) {},
                    // content: '',
                    controller: addNewProductCubit.linkVideoController,
                  ),
                  BlocBuilder<AddNewProductCubit, AddNewProductState>(
                    builder: (context, state) {
                      return QuentityItem(
                        text: 'quantity',
                        onIncrement: addNewProductCubit.incrementQty,
                        onDecrement: addNewProductCubit.decrementQty,
                        qty: addNewProductCubit.qty,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // AdsItem(
                  //   text: '',
                  //   isMessage: true,
                  //   content: 'الحالة',
                  //   widget: DropdownButtonHideUnderline(
                  //     child: Directionality(
                  //       textDirection: TextDirection.rtl,
                  //       child: DropdownButton<String?>(
                  //         value: value,
                  //         items: items.map(buildMenuItem).toList(),
                  //         onChanged: (String? value) {},
                  //         isExpanded: true,
                  //         icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  //         hint: const Text('القسم الفرعى'),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  AdsItem(
                    text: 'shipping_price',
                    keyboardType: TextInputType.phone,
                    isMessage: false,
                    onChanged: (v) {},
                    // content: 'سعر الشحن',
                    controller: addNewProductCubit.shippingPriceController,
                  ),
                  AdsItem(
                    text: 'payment_method'.translate,
                    isMessage: false,
                    // content: 'طرق الدفع',
                    widget: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DropdownButtonFormField<String?>(
                        value: addNewProductCubit.paymentMethod,
                        items: List.generate(
                          addNewProductCubit.paymentTypes.length,
                          (index) => DropdownMenuItem(
                            value: addNewProductCubit.paymentTypes[index],
                            child: Text(
                              addNewProductCubit.paymentTypes[index]
                                  .replaceAll(' ', '_')
                                  .translate,
                            ),
                          ),
                        ),
                        onChanged: addNewProductCubit.onPaymentMethod,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        // hint: const Text('الدفع عند الاستلام'),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'payment_method'.translate),
                      ),
                    ),
                  ),
                  AdsItem(
                    text: 'product_status'.translate,
                    isMessage: false,
                    // : 'طرق الدفع',
                    widget: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DropdownButtonFormField<String?>(
                        value: addNewProductCubit.productStatus,
                        items: List.generate(
                          addNewProductCubit.paymentTypes.length,
                          (index) => DropdownMenuItem(
                            value: addNewProductCubit.status[index],
                            child: Text(
                              addNewProductCubit.status[index].translate,
                            ),
                          ),
                        ),
                        onChanged: addNewProductCubit.onStatusMethod,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        // hint: const Text('الدفع عند الاستلام'),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'product_status'.translate),
                      ),
                    ),
                  ),
                  // AdsItem(
                  //   text: '',
                  //   isMessage: false,
                  //   content: 'اظهار رقم الواتس اب',
                  //   widget: DropdownButtonHideUnderline(
                  //     child: Directionality(
                  //       textDirection: TextDirection.rtl,
                  //       child: DropdownButton<String?>(
                  //         value: value,
                  //         items: items.map(buildMenuItem).toList(),
                  //         onChanged: (String? value) {},
                  //         isExpanded: true,
                  //         icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  //         hint: const Text('نعم'),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  AdsItem(
                    text: 'hidden_data',
                    isMessage: true,
                    onChanged: (v) {},
                    // content: 'بيانات مخفية',
                    controller: addNewProductCubit.hiddenDataController,
                  ),
                  SizedBox(
                    height: Sizes.screenHeight() * 0.06,
                  ),
                  BlocBuilder<AddNewProductCubit, AddNewProductState>(
                    builder: (context, state) {
                      if (state is AddNewProductLoading) {
                        return const Center(
                          child: LoaderWidget(),
                        );
                      }
                      return CustomTextButton(
                        width: Sizes.screenWidth() * 0.9,
                        title: 'product_add',
                        function: () => addNewProductCubit.createNewProduct(
                            context: context),
                        radius: 25,
                      );
                    },
                  ),
                  SizedBox(
                    height: Sizes.screenHeight() * 0.06,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String?> buildMenuItem(String? item) => DropdownMenuItem(
        value: item,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            // decoration:  const BoxDecoration(
            //             border: Border(
            //                 bottom: BorderSide(color: MainStyle.navigationColor)),
            //           ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                item ==     'ads_advertise'.translate
                ? const Icon(Icons.work)
                    : item ==     'good_advertisment'.translate
              ? const Icon(Icons.shopping_cart)
                        : const Icon(Icons.account_balance_wallet),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  item!,
                ),
              ],
            ),
          ),
        ),
      );
}

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    super.key,
    required this.value,
    required this.onDelete,
  });
  final String value;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.r, vertical: 5.r),
      decoration: BoxDecoration(
        color: Colors.black,
        // border: Border.all(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(4.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: MainTheme.appBarTextStyle,
          ),
          const BoxHelper(
            width: 15,
          ),
          InkWell(
            onTap: onDelete,
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 13.r,
            ),
          )
        ],
      ),
    );
  }
}
