import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/common_card.dart';
import 'package:creen/core/utils/widgets/common_favorite_view.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/cart/viewModel/addToCart/add_to_cart_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketItem extends StatelessWidget {
  final String? imagePath, name, price;
  final bool isLike;
  final bool addedToCart;
  final void Function()? onTap;
  final void Function()? onFavPressed;
  final int? productId;

  const MarketItem({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.price,
    this.isLike = false,
    this.onTap,
    this.onFavPressed,
    this.productId,
    required this.addedToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CommonCard(
        radius: 15,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CommonCard(
                  radius: 15,
                  height: Sizes.screenHeight() * 0.22,
                  //width: Sizes.screenWidth() * 0.47,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imagePath ?? '',
                      fit: BoxFit.fill,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/product.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: MainTheme.authTextStyle
                        .copyWith(fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '${price ?? ''} RS ',
                    style: MainTheme.authTextStyle.copyWith(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    height: 1,
                    color: MainStyle.mainGray,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonFavoriteView(
                          onTap: onFavPressed ?? () {},
                          icon: isLike
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          isSelected: isLike,
                        ),
                        Container(
                          height: 25,
                          width: 1,
                          color: MainStyle.mainGray,
                        ),
                        BlocBuilder<AddToCartCubit, AddToCartState>(
                          builder: (context, state) {
                            if (state ==
                                AddToCartLoading(
                                  productId: productId ?? 0,
                                )) {
                              return const LoaderWidget();
                            }
                            return InkWell(
                              onTap: () {
                                if (productId == null) {
                                  return;
                                }
                                context.read<AddToCartCubit>().addToCart(
                                      context,
                                      productId: productId,
                                    );
                              },
                              child: addedToCart
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        color: Colors.green,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.add_shopping_cart,
                                      color: MainStyle.primaryColor,
                                      size: 20,
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
