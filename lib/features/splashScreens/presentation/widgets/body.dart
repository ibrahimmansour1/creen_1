import 'package:creen/core/utils/connectivity/connectivity_service.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/image_bg.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import '../../../../core/utils/widgets/terms_accept_dialog.dart';

class SplashViewBody extends ConsumerWidget {
  const SplashViewBody({Key? key}) : super(key: key);

// Upgrader upgrade;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    determinePage(
      context: context,
    );
    return UpgradeAlert(
      upgrader: Upgrader(
        canDismissDialog: false,
        showLater: true,
        showIgnore: true,
        messages: MyUpgraderMessages(),
        // debugDisplayOnce: false,
        durationUntilAlertAgain: const Duration(milliseconds: 100),
        // countryCode: "en"
      ),
      child:  Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(kAppLogog),fit: BoxFit.cover),
        ),
        child: const ImageBG(
          network: false,
          image: 'assets/images/logoo.png',
          // width: double.infinity,
          // height: double.infinity,
        ),
      ),
    );
  }

  void determinePage({
    required BuildContext context,
  }) async {
    if (!GetStorage().hasData('accepted_rules')) {
      await Future.delayed(const Duration(seconds: 1), () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const TermsAcceptDialog(),
        );
      });
    }
    ConnectivityService.instance.checkIfConnected().then((value) async {
      await Future.delayed(const Duration(seconds: 2), () {});
      if (value) {
        // bool isFirstTime = GetStorage().read(kIsFirstTime) ?? true;

        // if (isFirstTime) {
        //   NavigationService.pushReplacementAll(
        //       page: RoutePaths.authLogin, isNamed: true);
        // } else {
        //   bool isLoggedIn = GetStorage().read(kIsLoggedIn) ?? false;

        //   if (isLoggedIn) {
        //     //await authNotifier.fetchUserData();
        //   } else {
        //     NavigationService.pushReplacementAll(
        //         page: RoutePaths.authLogin, isNamed: true);
        //   }
        // }
        NavigationService.pushAndRemoveUntil(
          page: RoutePaths.mainPage,
          isNamed: true,
          predicate: (p0) => false,
        );
        // if (HelperFunctions.isLoggedIn) {
        //   NavigationService.pushReplacementAll(
        //     page: RoutePaths.mainPage,
        //     isNamed: true,
        //   );
        // } else {
        //   NavigationService.pushReplacementAll(
        //     page: RoutePaths.authLogin,
        //     isNamed: true,
        //   );
        // }
      } else {
        NavigationService.push(
          isNamed: true,
          page: RoutePaths.coreNoInternet,
          arguments: {'fromSplash': true},
        );
      }
    });
  }
}

class MyUpgraderMessages extends UpgraderMessages {
  @override
  String get buttonTitleIgnore => 'ignore'.translate;//'ignore';
  @override
  String get buttonTitleLater => 'later'.translate;
  @override
  String get buttonTitleUpdate => 'update'.translate;
/*  @override
  String get title => 'upgradenowtitle';*/
  @override
  String get prompt => 'update_app_now'.translate;
  @override
  String get body => '';
}