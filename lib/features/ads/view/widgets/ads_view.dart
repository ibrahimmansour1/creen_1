import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../model/ad_data.dart';
import 'custom_ad.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class AdsView extends StatelessWidget {
  const AdsView({
    super.key,
    required this.ads,
    required this.scrollController,
  });
  final ScrollController scrollController;

  final List<AdData> ads;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Sizes.screenHeight() * 0.15,
      ),
      child: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          var ad = ads[index];
          return InkWell(
            onTap: () {
              NavigationService.push(
                page: RoutePaths.viewAd,
                arguments: ad.id,
                isNamed: true,
              );
            },
            child: CustomAdCard(
              adsImage: ad.image?.url,
              adsTitle: ad.text?.content,
              timesAgo: timeAgo.format(
                ad.createdAt ?? DateTime.now(),
                locale: HelperFunctions.currentLanguage,
              ),
            ),
          );
        },
        itemCount: ads.length,
      ),
    );
  }
}
