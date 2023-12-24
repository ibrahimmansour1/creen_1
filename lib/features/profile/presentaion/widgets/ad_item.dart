import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/ads/model/ad_data.dart' hide Image, Text;
import 'package:creen/features/ads/viewModel/ads/ads_cubit.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/themes/screen_utitlity.dart';
import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/routing/route_paths.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/table_text.dart';

class AdItem extends StatelessWidget {
  const AdItem({
    Key? key,
    required this.title,
    required this.clicks,
    required this.views,
    required this.adImage,
    required this.adId,
    required this.ad,
  }) : super(key: key);
  final String title;
  final String clicks;
  final String views;
  final String adImage;
  final int adId;
  final AdData ad;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.r),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: MainStyle.lightGreyColor,
      //   ),
      // ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (adImage.isEmpty) {
                    return;
                  }
                  showImageViewer(
                    context,
                    Image.network(adImage).image,
                    doubleTapZoomable: true,
                    swipeDismissible: true,
                  );
                },
                child: Container(
                  height: 180.r,
                  width: 180.r,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: MainStyle.lightGreyColor),
                    color: Colors.white,
                  ),
                  child: adImage.isNotEmpty
                      ? Image.network(
                          adImage,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/product.jpg',
                        ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 180.r,
                  // width: 150.r,
                  // padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: MainStyle.lightGreyColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const TableText(
                      //   verticalPadding: 5,
                      //   title: 'العنوان',
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: TableText(
                              verticalPadding: 5,
                              title: title,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'view') {
                                NavigationService.push(
                                  page: RoutePaths.viewAd,
                                  arguments: ad.id,
                                  isNamed: true,
                                );
                              } else if (value == 'edit') {
                                NavigationService.push(
                                  page: RoutePaths.createAds,
                                  isNamed: true,
                                  arguments: {
                                    'all_ads_cubit':
                                        context.read<AllAdsCubit>(),
                                    'ad': ad,
                                  },
                                );
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
                                              .read<AllAdsCubit>()
                                              .deleteAdById(
                                                adId: adId,
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
                              var isMe =
                                  ad.userId == HelperFunctions.currentUser?.id;
                              return [
                                if (isMe) ...[
                                  HelperFunctions.buildPopupMenu(
                                    icons: FontAwesomeIcons.penSquare,
                                    title: 'edit'.translate,
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
                                    title: 'promote',
                                  ),
                                  HelperFunctions.buildPopupMenu(
                                    icons: Icons.delete,
                                    title: 'delete'.translate,
                                    value: 'delete',
                                  ),
                                ],
                              ];
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Column(
                            children: [
                               TableText(
                                verticalPadding: 5,
                                title: 'clicks'.translate,
                              ),
                              TableText(
                                verticalPadding: 5,
                                title: clicks,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            children: [
                               TableText(
                                verticalPadding: 5,
                                title: 'watch'.translate,
                              ),
                              TableText(
                                verticalPadding: 5,
                                title: views,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const Divider(),
                      const BoxHelper(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // const BoxHelper(
          //   height: 15,
          // ),
          // BoxHelper(
          //   width: 90,
          //   height: 40,
          //   child: RegisterButton(
          //     removePadding: true,
          //     radius: 12,
          //     title: 'عرض',
          //     onPressed: () {},
          //   ),
          // ),
          // const BoxHelper(
          //   height: 15,
          // ),
        ],
      ),
    );
  }
}
