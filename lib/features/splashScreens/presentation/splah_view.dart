import 'package:creen/core/utils/responsive/responsive_service.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

import 'widgets/body.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
         ResponsiveService().init(context);
    return const Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.black,
      body: SplashViewBody(),
    );
  }
}
