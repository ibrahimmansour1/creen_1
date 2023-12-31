import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/ads/view/pages/photo_ad.dart';
import 'package:creen/features/ads/view/pages/text_ad.dart';
import 'package:creen/features/ads/view/pages/video_ad.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:creen/features/share/presentation/widgets/share_item.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/routing/route_paths.dart';

class AddAdsScreen extends ConsumerWidget {
  const AddAdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: const NavigationDrawer(),

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'add_ad',
          )),
      //backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.black45],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                tileMode: TileMode.clamp)),
        child: Container(
          // width: Sizes.screenWidth(),
          // height: Sizes.screenHeight(),
          //padding: const EdgeInsets.all(25.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Sizes.screenWidth() * 0.18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShareItem(
                      const ImageIcon(AssetImage('assets/images/Group.png')),
                      'public_ad', () {
                    NavigationService.push(
                      page: RoutePaths.createAds,
                      isNamed: true,
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  ShareItem(
                      const ImageIcon(AssetImage('assets/images/text.png')),
                      'text_ad', () {
                    NavigationService.push(
                        page: TextAdScreen(), isNamed: false);
                  }),
                ],
              ),
              SizedBox(
                height: Sizes.screenWidth() * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShareItem(
                      const ImageIcon(AssetImage('assets/images/camera.png')),
                      'image_ad', () {
                    NavigationService.push(
                        page: PhotoAdScreen(), isNamed: false);
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  ShareItem(
                      const ImageIcon(AssetImage('assets/images/video.png')),
                      'video_ad', () {
                    NavigationService.push(
                        page: VideoAdScreen(), isNamed: false);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
