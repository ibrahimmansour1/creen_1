import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/app_loader.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/features/ads/view/widgets/ads_item.dart';
import 'package:creen/features/cart/viewModel/addToCart/add_to_cart_cubit.dart';
import 'package:creen/features/market/viewModel/allProducts/all_products_cubit.dart';
import 'package:creen/features/market/viewModel/reaction/reaction_cubit.dart';
import 'package:creen/features/market/viewModel/specificProduct/specific_product_cubit.dart';
import 'package:creen/features/subject/view/widgets/comment_item.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/customized_read_more.dart';
import '../../../../core/utils/widgets/loader_widget.dart';
import '../../../videos/presentaion/widgets/video_player_item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    this.isOwner = false,
  }) : super(key: key);
  final bool isOwner;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late SpecificProductCubit specificProductCubit;
  bool videoIndicator = true;
  String testImage1 =
      "https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821";

  List<ColorModel> colors = [
    ColorModel(color: '123456'),
    ColorModel(color: '495E57'),
    ColorModel(color: 'FAF8ED'),
  ];

  @override
  void initState() {
    specificProductCubit = context.read<SpecificProductCubit>()..viewProduct();
    // specificProductCubit.productData?.video = "https://creen-program.com/storage/lives/phps1OgZ6.mp4";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(size: size),
      bottomNavigationBar: SizedBox(
        width: size.width,
        height: size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.black,
                  ),
                  Text(
                    'دردشة',
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.8,
              height: size.height * 0.07,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'إضافه إلى عربة التسوق',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody({required Size size}) {
    return BlocBuilder<SpecificProductCubit, SpecificProductState>(
      builder: (context, state) {
        // print("specificProductCubit.productData?.video??"").isNotEmpty ${(specificProductCubit.productData?.video??"").isNotEmpty}");
        if (state is SpecificProductLoading) {
          return const AppLoader();
        }
        return SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Stack(
                children: [
                  specificProductCubit.productData?.images?.isEmpty == true
                      ? Container(
                          height: size.height * 0.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: specificProductCubit.productData?.image ==
                                      null
                                  ? const AssetImage(
                                      'assets/images/product.jpg')
                                  : NetworkImage(specificProductCubit
                                          .productData?.image?.url ??
                                      '') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : CarouselSlider.builder(
                          itemBuilder: (_, index, realIndex) {
                            // log('index ${index}');
                            specificProductCubit.updateIndex(index: index);

                            if (index ==
                                (specificProductCubit
                                        .productData?.images?.length ??
                                    0)) {
                              return const VideoPlayerItem(
                                videoUrl:
                                    "https://creen-program.com/storage/lives/phps1OgZ6.mp4",
                                hei: 0.5,
                              );
                            } else {
                              var image = specificProductCubit
                                  .productData?.images?[index];
                              return InkWell(
                                onTap: () {
                                  if (image?.url == null) {
                                    return;
                                  }
                                  showImageViewerPager(
                                    context,
                                    MultiImageProvider(
                                      List.generate(
                                          specificProductCubit.productData
                                                  ?.images?.length ??
                                              0, (index) {
                                        var image = specificProductCubit
                                            .productData?.images?[index];
                                        return NetworkImage(image?.url ?? '');
                                      }),
                                    ),
                                    swipeDismissible: true,
                                  );
                                },
                                child: Image.network(
                                  image?.url ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            }
                          },
                          itemCount: !videoIndicator
                              ? (specificProductCubit
                                      .productData?.images?.length ??
                                  0)
                              : ((specificProductCubit
                                          .productData?.images?.length ??
                                      0) +
                                  1),
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              height: size.height * 0.5,
                              autoPlay: false,
                              viewportFraction: 1),
                        ),
                  // if((specificProductCubit.productData?.video??"").isNotEmpty)
/*
                  Positioned(
                                  // top: 0,
                                  bottom: 5.r,
                                  left: 0,
                                  right: 0,
                                  child: SafeArea(
                                    child: Padding(
                                      // color: Colors.black45,
                                      padding: EdgeInsets.fromLTRB(
                                        20,
                                        10,
                                        20,
                                        size.height * 0.07,
                                      ),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          color: Colors.black45,
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.5,
                                                      child: Text(
                                                          specificProductCubit
                                                              .productData?.title ??
                                                              'زبدة الشيا الخام',
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                          style: MainTheme.appBarTextStyle
                                                              .copyWith(fontSize: 20)),
                                                    ),
                                                    Text(
                                                        specificProductCubit.productData
                                                            ?.category?.name ??
                                                            'قسم العناية',
                                                        style: MainTheme.appBarTextStyle
                                                            .copyWith(fontSize: 14)),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        (specificProductCubit
                                                            .productData?.seen ??
                                                            0)
                                                            .toString(),
                                                        style: MainTheme.appBarTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Icon(
                                                        Icons.remove_red_eye_outlined,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        specificProductCubit
                                                            .productData?.rates
                                                            .toString() ??
                                                            '4',
                                                        style: MainTheme.appBarTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
*/

                  Positioned(
                    left: 20,
                    top: 28.r,
                    right: 20,
                    child: SizedBox(
                      // color: Colors.black54,
                      height: size.height * 0.41,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                              ),
                              Row(
                                children: <Widget>[
                                  const CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/share.png'),
                                      color: Colors.white,
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Visibility(
                                    visible: !widget.isOwner,
                                    child: BlocBuilder<AllProductsCubit,
                                        AllProductsState>(
                                      builder: (context, state) {
                                        var isFav = specificProductCubit
                                                .productData?.isLike ==
                                            true;
                                        return CircleAvatar(
                                          backgroundColor: Colors.black54,
                                          child: InkWell(
                                            onTap: specificProductCubit
                                                        .productData ==
                                                    null
                                                ? null
                                                : () => context
                                                    .read<ReactionCubit>()
                                                    .likeProduct(
                                                      context,
                                                      isLike:
                                                          specificProductCubit
                                                                  .productData
                                                                  ?.isLike ??
                                                              false,
                                                      productId:
                                                          specificProductCubit
                                                              .productData?.id,
                                                    ),
                                            child: Icon(
                                              isFav
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_rounded,
                                              color: isFav
                                                  ? Colors.red
                                                  : Colors.white,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: size.width * 0.15,
                                ),
                                if ((specificProductCubit.productData?.images ??
                                        [])
                                    .isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius:
                                            BorderRadiusDirectional.horizontal(
                                                start: Radius.circular(30),
                                                end: Radius.circular(30))),
                                    child: Text(
                                      '${specificProductCubit.carsoulSliderIndex}/${!videoIndicator ? (specificProductCubit.productData?.images?.length ?? 0) : ((specificProductCubit.productData?.images?.length ?? 0) + 1)}',
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  radius: 15,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.bookmark_outline,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.only(top: size.height * 0.45),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.06,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Colors.yellow,
                            Colors.orangeAccent,
                            Colors.orange
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '⚡خصم سريع',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'ينتهي في ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: const Text(
                                      '45',
                                      style:
                                          TextStyle(color: Colors.orangeAccent),
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: const Text(
                                      '45',
                                      style:
                                          TextStyle(color: Colors.orangeAccent),
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: const Text(
                                      '45',
                                      style:
                                          TextStyle(color: Colors.orangeAccent),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Text(
                        'عرض حصري لمركز تسوق tik Tok',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      const Text(
                        'SAR30.00',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      ),
                      Row(
                        children: [
                          const Text(
                            'SAR59.00',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.pink[50],
                                borderRadius: BorderRadius.circular(3)),
                            child: const Text(
                              '49%-',
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomizedReadMore(
                              data: specificProductCubit
                                      .productData?.description ??
                                  "فر نفس الموديل مخده 1مخده مربع ٢٦٠﷼", // style: MainTheme.authTextStyle.copyWith(
                              //     fontWeight: FontWeight.normal, fontSize: 13),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Text(
                                  '⭐4.5',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  '/5   |   ',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  '4671',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'مباع',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Text(
                                  'اللون: ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'الفضه',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.width * 0.1,
                              child: ListView.builder(
                                itemBuilder: (context, index) => Container(
                                  width: size.width * 0.1,
                                  height: size.width * 0.1,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Color(int.parse(
                                          'ff${colors[index].color}',
                                          radix: 16)),
                                      border: colors[index].selected
                                          ? Border.all(color: Colors.black)
                                          : null,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                itemCount: colors.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Text('مقاس:',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      Text('مقاس واحد',
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius:
                                          const BorderRadiusDirectional
                                              .horizontal(
                                              start: Radius.circular(30),
                                              end: Radius.circular(30)),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'دليل الحجم',
                                          style: TextStyle(
                                              color: Colors.grey.shade700),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey.shade700,
                                          size: 13,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Text(
                                'مقاس واحد',
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            Divider(
                              thickness: 5,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                ))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.delivery_dining),
                                    SizedBox(
                                      width: size.width * 0.7,
                                      child: RichText(
                                        text: TextSpan(
                                            text:
                                                ' وجهة الشحن المملكة العربية السعودية\n',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 19),
                                            children: [
                                              TextSpan(
                                                  text: 'شحن مجاني\t',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .tealAccent.shade700,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: const [
                                                    TextSpan(
                                                        text:
                                                            'للطلبات التي تزيد على SAR49.00\n',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))
                                                  ]),
                                              const TextSpan(
                                                  text:
                                                      'من المتوقع أن يتم التسليم بين ',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                  children: [
                                                    TextSpan(
                                                        text: 'OCT 24 - 28',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22,
                                                            color:
                                                                Colors.black))
                                                  ])
                                            ]),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.assignment_return_outlined,
                                        color: Colors.black,
                                      ), //reset_tv
                                      Text(
                                        ' الإرجاع في غضون 30 يوماً',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.wallet_outlined,
                                        color: Colors.black,
                                      ), //reset_tv
                                      Text(
                                        ' مؤهلة للدفع نقداً عند التسليم',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.verified_user_outlined,
                                        color: Colors.black,
                                      ), //reset_tv
                                      Text(
                                        ' تسوق بثقة',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 5,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('التفاصيل',
                                        style: TextStyle(color: Colors.black)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                  ]),
                            ),
                            const Text(
                              '* أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  * أنيق  ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Divider(
                              thickness: 5,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('دليل الحجم',
                                        style: TextStyle(color: Colors.black)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                  ]),
                            ),
                            Divider(
                              thickness: 5,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('تقييمات العملاء(341)',
                                        style: TextStyle(color: Colors.black)),
                                    Row(
                                      children: [
                                        Text(
                                          'عرض المزيد',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                            Row(
                              children: [
                                const Text('4.5/'),
                                const Text(
                                  '5',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  itemSize: 20,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.22 * 2,
                              child: ListView.separated(
                                itemBuilder: (_, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(testImage1),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const Text(
                                          ' Name',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      itemSize: 20,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    const Text(
                                        'السلعه: لون  وردي فاتح , مقاس واحد',
                                        style: TextStyle(color: Colors.grey)),
                                    const Text(
                                      'مرة أنصحكم فيها',
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                        width: size.width,
                                        height: size.width * 0.1,
                                        child: ListView.builder(
                                          itemBuilder: (_, imageIndex) =>
                                              Container(
                                            width: size.width * 0.1,
                                            height: size.width * 0.1,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(testImage1),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          itemCount: 3,
                                          scrollDirection: Axis.horizontal,
                                        )),
                                  ],
                                ),
                                itemCount: 2,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(height: 10);
                                },
                              ),
                            ),
                            Divider(
                              thickness: 5,
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            const Text('قد يعجبك أيضاً',
                                style: TextStyle(fontSize: 20)),
                            SizedBox(
                                height: size.height * 0.4,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 2,
                                          mainAxisExtent: size.height * 0.4),
                                  itemBuilder: (context, index) => Container(
                                    // width:size.width/2-10,
                                    height: size.height * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: [
                                        Stack(
                                          alignment: const Alignment(-0.8,0.8),
                                          children: [
                                            Container(
                                              height:size.height*0.2,
                                              clipBehavior: Clip.hardEdge,
                                              decoration:BoxDecoration(
                                                image:DecorationImage(
                                                  image: NetworkImage(testImage1,),
fit:BoxFit.cover,
                                                )
                                              )
                                            ),
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: const Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ))),
                                          ],
                                        ),
                                        Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: const Text(
                                              'تخفيضات الموضه',
                                              maxLines:1,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width:size.width*0.2,child: const Text('حقيبة توت نسائية',maxLines:1,overflow: TextOverflow.ellipsis,)),
                                        ]),
                                        const Text(
                                          'بنمط ألوان متباينة مرقع , حقيبببببببه',
                                          maxLines: 1,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.pink.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: const Row(children: [
                                              Icon(Icons.local_fire_department,
                                                  color: Colors.pink),
                                              Text('صفقات مثيرة'),
                                            ])),
                                        const Text('SAR63.00',
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Row(children: [
                                          const Text('SAR99.00',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              )),
                                          Container(
                                              decoration: BoxDecoration(
                                                color: Colors.pink.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Text('36%-',
                                                  style: TextStyle(
                                                      color: Colors.pink,
                                                      fontSize: 12))),
                                        ]),
                                        const Text('⭐️4.5|تم بيع 462',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  itemCount: 2,
                                )),
                            Row(
                              children: [
                                Text(
                                  '${'payment_method'.translate} : ',
                                  style: MainTheme.authTextStyle
                                      .copyWith(fontSize: 16),
                                ),
                                Container(
                                  height: Sizes.screenHeight() * 0.07,
                                  width: Sizes.screenWidth() * 0.42,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  decoration: const BoxDecoration(
                                      color: MainStyle.shareColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffE7E7E7)),
                                          left: BorderSide(
                                              color: Color(0xffE7E7E7)),
                                          right: BorderSide(
                                              color: Color(0xffE7E7E7)),
                                          top: BorderSide(
                                              color: Color(0xffE7E7E7)))),
                                  child: Row(
                                    children: [
                                      const Icon(
                                          Icons.business_center_outlined),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        specificProductCubit
                                                .productData?.details?.payment
                                                ?.replaceAll(' ', '_')
                                                .translate ??
                                            'bank_transfer'.translate,
                                        style: MainTheme.authTextStyle.copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (!widget.isOwner) ...[
                              AdsItem(
                                text: '',
                                isMessage: true,
                                onChanged: (v) {},
                                hintText: 'add_comment',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              BlocBuilder<AddToCartCubit, AddToCartState>(
                                builder: (context, state) {
                                  if (state ==
                                      AddToCartLoading(
                                        productId: specificProductCubit
                                                .productData?.id ??
                                            0,
                                      )) {
                                    return const LoaderWidget();
                                  }
                                  return CustomTextButton(
                                    width: Sizes.screenWidth() * 0.9,
                                    title: 'add_to_cart',
                                    function: () {
                                      if (specificProductCubit.productData ==
                                          null) {
                                        return;
                                      }
                                      context.read<AddToCartCubit>().addToCart(
                                            context,
                                            productId: specificProductCubit
                                                .productData?.id,
                                          );
                                    },
                                    radius: 25,
                                  );
                                },
                              ),
                            ],
                            SizedBox(
                              height: Sizes.screenHeight() * 0.06,
                            ),
                          ],
                        ),
                      ),
                      ...List.generate(
                        specificProductCubit.productData?.comments?.length ?? 0,
                        (index) {
                          var comment = specificProductCubit
                              .productData?.comments?[index];
                          return CommentItem(
                            image: comment?.user?.profile,
                            name: comment?.user?.name,
                            text: comment?.comment,
                            deleteIconTap: () async {
                              log("delete comment");
                              await specificProductCubit.deleteComment();
                            },
                            editingIconTap: () {},
                            reportIconTap: () {},
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ColorModel {
  String color;
  bool selected;

  ColorModel({
    required this.color,
    this.selected = false,
  });
}
