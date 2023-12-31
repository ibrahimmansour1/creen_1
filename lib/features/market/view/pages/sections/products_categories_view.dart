
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/market/model/products_categories_model.dart';
import 'package:creen/features/market/view/pages/products_by_category_view.dart';
import 'package:creen/features/market/view/pages/sections/specific_product_section.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/themes.dart';
import '../../../../../core/utils/widgets/app_loader.dart';
import '../../../../../core/utils/widgets/box_helper.dart';
import '../../../viewModel/productsCategories/products_categories_cubit.dart';

class ProductsCategoriesView extends StatefulWidget {
  const ProductsCategoriesView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsCategoriesView> createState() => _ProductsCategoriesViewState();
}

class _ProductsCategoriesViewState extends State<ProductsCategoriesView> {
  late ProductsCategoriesCubit productsCategoriesCubit;

  @override
  void initState() {
    productsCategoriesCubit = context.read<ProductsCategoriesCubit>()
      ..getProductsCategories()
      ..initListeners();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCategoriesCubit, ProductsCategoriesState>(
      builder: (context, state) {
        if (state is ProductsCategoriesLoading) {
          return const AppLoader();
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          controller: productsCategoriesCubit.scrollController,
          itemCount: productsCategoriesCubit.productCategories.length,
          itemBuilder: (context, index) {
            var section = productsCategoriesCubit.productCategories[index];

            return ProductCatWidget(section: section);
          },
        );
      },
    );
  }
}

class ProductCatWidget extends StatelessWidget {
  const ProductCatWidget({
    Key? key,
    required this.section,
  }) : super(key: key);

  final ProductsCategory section;

  @override
  Widget build(BuildContext context) {
    var length = section.children?.length ?? 0;
    var isEven = length % 2 == 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.all(15.r),
          padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 5.r),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r),
              bottomLeft: Radius.circular(15.r),
            ),
          ),
          child: Text(
            section.name ?? '',
            style: MainTheme.authTextStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        Wrap(
          children: List.generate(length, (index) {
            var subCat = section.children?[index];
            return ProductCatChild(
              subCat: subCat,
              isLastOdd: length % 2 != 0 && index == length - 1,
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.r),
          child: const Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class ProductCatChild extends StatelessWidget {
  const ProductCatChild({
    Key? key,
    required this.subCat,
    required this.isLastOdd,
  }) : super(key: key);

  final ProductsCategory? subCat;
  final bool isLastOdd;

  @override
  Widget build(BuildContext context) {
    var i = isLastOdd ? 300 : 150;
    return Padding(
      padding: EdgeInsets.all(5.0.r),
      child: InkWell(
        onTap: () {
          NavigationService.push(
            page: SpecificProductSection(
              section: 'category',
              categoryId: subCat?.id,
              page: ProductsByCategoryScreen(
                title: subCat?.name,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image.network(
            //   subCat?.icon ?? '',
            //   width: 150.r,
            //   height: 150.r,
            // ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/logo.jpg',
              image: subCat?.icon ?? '',
              width: i.r,
              height: 150.r,
              fit: BoxFit.cover,
            ),
            BoxHelper(
              width: i,
              child: Text(
                subCat?.name ?? '',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: MainTheme.authTextStyle.copyWith(
                  fontSize: 15.r,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
