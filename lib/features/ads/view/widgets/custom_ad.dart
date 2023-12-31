import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

import '../../../../core/utils/functions/helper_functions.dart';

class CustomAdCard extends StatelessWidget {
  const CustomAdCard(
      {Key? key,
      this.adsTitle,
      this.publisherName,
      this.location,
      this.timesAgo,
      this.adsImage})
      : super(key: key);
  final String? adsTitle;
  final String? publisherName;
  final String? location;
  final String? timesAgo;
  final String? adsImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MainStyle.navigationColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
       textDirection: HelperFunctions.isArabic?TextDirection.rtl:TextDirection.ltr,
        children: [
          Image(
            image: adsImage == null
                ? const AssetImage(
                    'assets/images/product.jpg',
                  )
                : NetworkImage(
                    adsImage!,
                  ) as ImageProvider,
            fit: BoxFit.cover,
            height: Sizes.screenHeight() * 0.13,
            width: Sizes.screenWidth() * 0.27,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Sizes.screenWidth() * 0.6,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    (adsTitle ?? 'job_or_product_ad').translate,
                    style:
                        MainTheme.appBarTextStyle.copyWith(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: MainStyle.primaryColor,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    (publisherName ??'publisher_name').translate,
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: MainStyle.primaryColor,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        (location ?? 'location').translate,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Sizes.screenWidth() * 0.18,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_filled,
                        color: MainStyle.primaryColor,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        timesAgo ?? '',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
