import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/widgets/custom_image.dart';
import '../../viewModel/viewPromotion/view_promotion_cubit.dart';

class AdDetailsScreen extends StatefulWidget {
  const AdDetailsScreen({super.key});

  @override
  State<AdDetailsScreen> createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  late ViewPromotionCubit viewPromotionCubit;

  @override
  void initState() {
    viewPromotionCubit = context.read<ViewPromotionCubit>()..viewPromotion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: const CustomAppBar(
          title: 'ads_details',
          back: true,
        ),
      ),
      body: BlocBuilder<ViewPromotionCubit, ViewPromotionState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(viewPromotionCubit
                                .promotionData?.user?.profile
                                ?.toString() ??
                            ''),
                      ),
                      const BoxHelper(
                        width: 10,
                      ),
                      Text(
                        viewPromotionCubit.promotionData?.user?.name ?? '',
                        style: MainTheme.authTextStyle.copyWith(
                          fontSize: 15.r,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.r, horizontal: 10.r),
                  child: Center(
                    child: Text(
                      viewPromotionCubit.promotionData?.text?.content ?? '',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  viewPromotionCubit.promotionData?.images?.length ?? 0,
                  (index) {
                    var promotionImage =
                        viewPromotionCubit.promotionData?.images?[index];
                    return CustomImage(
                      networkImage: promotionImage?.url,
                      responsiveRadius: 10,
                      horizontalPadding: 0,
                      responsiveWidth: double.infinity,
                      responsiveHeight: 300,
                      boxFit: BoxFit.fill,
                    );
                  },
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (viewPromotionCubit.promotionData?.whatsapp !=
                          null) ...[
                        PromotionButton(
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                'https://wa.me/${viewPromotionCubit.promotionData!.whatsapp!}',
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          icons: FontAwesomeIcons.whatsapp,
                          title: "whats_conncet",
                          buttonColor: Colors.green,
                          txtColor: Colors.white,
                        ),
                      ],
                      if (viewPromotionCubit.promotionData?.link != null) ...[
                        PromotionButton(
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                viewPromotionCubit.promotionData!.link!,
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          icons: Icons.link,
                          title: 'source',
                          buttonColor: Colors.yellow,
                          txtColor: Colors.black,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PromotionButton extends StatelessWidget {
  const PromotionButton({
    super.key,
    required this.onTap,
    required this.buttonColor,
    required this.txtColor,
    required this.title,
    required this.icons,
  });

  final void Function() onTap;
  final Color buttonColor, txtColor;
  final String title;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 34.r,
        // width: 222.r,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(
              10.r,
            )),
        padding: EdgeInsets.all(4.r),
        margin: EdgeInsets.all(4.r),
        child: Row(
          children: [
            Icon(
              icons,
              color: txtColor,
            ),
            const BoxHelper(
              width: 10,
            ),
            Text(
              title.translate,
              style: MainTheme.appBarTextStyle.copyWith(
                color: txtColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
