import 'dart:developer';

import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/core/utils/widgets/register_button.dart';
import 'package:creen/features/market/model/product_data_model.dart';
import 'package:creen/features/market/view/pages/add_product.dart';
import 'package:creen/features/market/viewModel/addNewProduct/add_new_product_cubit.dart';
import 'package:creen/features/market/viewModel/allProducts/all_products_cubit.dart';
import 'package:creen/features/market/viewModel/productsCategories/products_categories_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../market/viewModel/reaction/reaction_cubit.dart';
import '../../../market/viewModel/specificProduct/specific_product_cubit.dart';
import '../../../products/presentaion/pages/detail_page.dart';

class MyProductsScreen extends StatefulWidget {
   MyProductsScreen({Key? key}) : super(key: key);
  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  late AllProductsCubit allProductsCubit;

  @override
  void initState() {
    allProductsCubit = context.read()..getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: const CustomAppBar(
          title: 'myproducts',
          back: true,
        ),
      ),
      body: BlocBuilder<AllProductsCubit, AllProductsState>(
        builder: (context, state) {
          if (state is AllProductsLoading) {
            return const LoaderWidget(
              color: Colors.white,
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BoxHelper(
                height: 10,
              ),
             if(arg ==1) BoxHelper(
                width: 140,
                child: RegisterButton(
                  color: Colors.white,
                  radius: 10,
                  title: 'add_product',
                  onPressed: () {
                    NavigationService.push(
                      page: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => AddNewProductCubit(),
                          ),
                          BlocProvider(
                            create: (context) => ProductsCategoriesCubit(),
                          ),
                          BlocProvider.value(
                            value: allProductsCubit,
                          ),
                        ],
                        child: const AddProductScreen(),
                      ),
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10.r),
              //   child: const MyProductsTable(),
              // ),

              allProductsCubit.products.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'no_products_added'.translate,
                          style: MainTheme.authTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: allProductsCubit.products.length,
                        itemBuilder: (context, index) {
                          var product = allProductsCubit.products[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.r, horizontal: 15.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.r, vertical: 8.r),
                                          child: InkWell(
                                            onTap: () {
                                              viewProduct(product);
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              child: Image.network(
                                                product.image?.url ?? '',
                                                height: 90.r,
                                                width: 90.r,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Image.asset(
                                                  'assets/images/product.jpg',
                                                  height: 90.r,
                                                  width: 90.r,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const BoxHelper(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BoxHelper(
                                              width: 150,
                                              child: InkWell(
                                                onTap: () {
                                                  viewProduct(product);
                                                },
                                                child: Text(
                                                  '${'name'.translate} : ${product.title}',
                                                ),
                                              ),
                                            ),
                                            const BoxHelper(
                                              height: 15,
                                            ),
                                            Text('${'price'.translate} :  ${product.price}'),
                                            const BoxHelper(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    PopupMenuButton(
                                      onSelected: (value) {
                                        log('n');
                                        if (value == 'edit') {
                                          NavigationService.push(
                                            page: MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create: (context) =>
                                                      AddNewProductCubit(
                                                    product: product,
                                                  ),
                                                ),
                                                BlocProvider(
                                                  create: (context) =>
                                                      ProductsCategoriesCubit(),
                                                ),
                                                BlocProvider.value(
                                                  value: allProductsCubit,
                                                ),
                                              ],
                                              child: const AddProductScreen(),
                                            ),
                                          );
                                        } else if (value == 'view') {
                                          viewProduct(product);
                                        } else if (value == 'delete') {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text(
                                                'delete'.translate,
                                              ),
                                              content: Text(
                                                'do_you_want_to_scan'.translate,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    NavigationService.goBack();
                                                    context
                                                        .read<
                                                            AllProductsCubit>()
                                                        .deleteProductById(
                                                          productId: product.id,
                                                        );
                                                  },
                                                  child: Text(
                                                    'yes'.translate,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    NavigationService.goBack();
                                                  },
                                                  child: Text(
                                                    'no'.translate,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      position: PopupMenuPosition.under,
                                      itemBuilder: (_) {
                                        var isMe = product.userId ==
                                            HelperFunctions.currentUser?.id;
                                        return [
                                          if (isMe) ...[
                                            HelperFunctions.buildPopupMenu(
                                              icons: FontAwesomeIcons.penSquare,
                                              title: 'edit',
                                              value: 'edit',
                                            ),
                                          ],
                                          HelperFunctions.buildPopupMenu(
                                            icons: Icons.star,
                                            title: 'view',
                                            value: 'view',
                                          ),
                                          if (isMe) ...[
                                            HelperFunctions.buildPopupMenu(
                                              icons: Icons.ads_click_outlined,
                                              title: 'ترويج',
                                            ),
                                            HelperFunctions.buildPopupMenu(
                                              icons: Icons.delete,
                                              title: 'delete',
                                              value: 'delete',
                                            ),
                                          ],
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.r, vertical: 10.r),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BottomIconsTile(
                                        icons: Icons.visibility,
                                        data: product.seen?.toString() ?? '0',
                                      ),
                                      const BoxHelper(
                                        width: 7,
                                      ),
                                      BottomIconsTile(
                                        icons: Icons.favorite,
                                        data: product.likesCount?.toString() ??
                                            '0',
                                      ),
                                      const BoxHelper(
                                        width: 7,
                                      ),
                                      BottomIconsTile(
                                        icons: Icons.star,
                                        data: product.rates?.toString() ?? '0',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> viewProduct(ProductDetailsData product) {
    return NavigationService.push(
        page: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: allProductsCubit,
            ),
            BlocProvider.value(
              value: ReactionCubit(),
            ),
            BlocProvider(
              create: (_) => SpecificProductCubit(
                productId: product.id,
              ),
            ),
          ],
          child: const DetailPage(
            isOwner: true,
            // product: product,
          ),
        ),
        isNamed: false);
  }
}

class BottomIconsTile extends StatelessWidget {
  const BottomIconsTile({
    super.key,
    required this.data,
    required this.icons,
  });
  final String data;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icons),
        const BoxHelper(
          width: 10,
        ),
        Text(data),
      ],
    );
  }
}
