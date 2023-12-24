import 'dart:developer';

import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/cart/viewModel/cart/cart_cubit.dart';
import 'package:creen/features/market/viewModel/allProducts/all_products_cubit.dart';
import 'package:creen/features/market/viewModel/reaction/reaction_cubit.dart';
import 'package:creen/features/market/viewModel/specificProduct/specific_product_cubit.dart';
import '../../../../../core/themes/themes.dart';
import '../../widgets/market_item.dart';
import 'package:creen/features/products/presentaion/pages/detail_page.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';

class ProductsSectionsView extends StatefulWidget {
  const ProductsSectionsView({Key? key}) : super(key: key);

  @override
  State<ProductsSectionsView> createState() => _ProductsSectionsViewState();
}

class _ProductsSectionsViewState extends State<ProductsSectionsView> {
  late AllProductsCubit allProductsCubit;
  late CartCubit cartCubit;

  @override
  void initState() {
    cartCubit = context.read<CartCubit>();
    allProductsCubit = context.read<AllProductsCubit>()
      ..initScroller()
      ..getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TabController? controller =TabController(length: 5, vsync: this, initialIndex: 0);
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return BlocBuilder<AllProductsCubit, AllProductsState>(
          builder: (context, state) {
            if (state is AllProductsLoading) {
              return const LoaderWidget();
            }
            if (allProductsCubit.products.isEmpty) {
              return Center(
                child: Text(
                  'لا يوجد منتجات حاليا',
                  style: MainTheme.authTextStyle.copyWith(fontSize: 16),
                ),
              );
            }
            return GridView.builder(
              controller: allProductsCubit.scrollController,
              primary: false,
              shrinkWrap: true,
              itemCount: allProductsCubit.products.length,
              itemBuilder: (context, index) {
                var product = allProductsCubit.products[index];
                log('productNAme ${product.title} ${allProductsCubit.productsSection}');
                return MarketItem(
                  addedToCart:
                      cartCubit.containsProduct(productId: product.id),
                  onTap: () {
                    NavigationService.push(
                        page: MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: allProductsCubit,
                            ),
                            BlocProvider.value(
                              value: context.read<ReactionCubit>(),
                            ),
                            BlocProvider(
                              create: (_) => SpecificProductCubit(
                                productId: product.id,
                              ),
                            ),
                          ],
                          child: const DetailPage(
                              // product: product,
                              ),
                        ),
                        isNamed: false);
                  },
                  isLike: product.isLike ?? false,
                  onFavPressed: () =>
                      context.read<ReactionCubit>().likeProduct(
                            context,
                            isLike: product.isLike ?? false,
                            productId: product.id,
                          ),
                  imagePath: product.image?.url,
                  name: product.title,
                  price: product.price.toString(),
                  productId: product.id,
                );
              },
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                //crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 0.71,
              ),
            );
          },
        );
      },
    );
  }
}
