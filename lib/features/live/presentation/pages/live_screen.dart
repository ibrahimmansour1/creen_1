import 'package:creen/core/utils/constants.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:creen/features/live/presentation/pages/live_main_screen.dart';
import 'package:creen/features/live/viewModel/live/live_main_cubit.dart';
import 'package:creen/features/videos/viewModel/videos/videos_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../viewModel/live/live_main_state.dart';
late VideosCubit liveCubit ;

class LiveScreen extends StatefulWidget {
  const LiveScreen({
    super.key,
  });

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {

bool openScreen = false;
InterstitialAd? _interstitialAd;
void loadInterstitialAd() {
  InterstitialAd.load(
    adUnitId: 'ca-app-pub-9259263566568628/5580711691',
    request: const AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            // _moveToHome();
          },
        );


setState(() {
  _interstitialAd = ad;
});
      },
      onAdFailedToLoad: (err) {
        if (kDebugMode) {
          print('Failed to load an interstitial ad: ${err.message}');
        }
      },
    ),
  );
}

  @override
  void initState() {
    loadInterstitialAd();
    liveCubit = context.read<VideosCubit>()..getVideos(context);

    liveCubit.initController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(liveCubit.videos.isEmpty && openScreen) {
      return const CircularProgressIndicator();
    } else {
      return BlocProvider(create: (context)=>LiveMainCubit(),
      child: BlocConsumer<LiveMainCubit,LiveMainStates>(
        listener: (context,LiveMainStates state){

        }, builder: (BuildContext context,LiveMainStates state) {
          return Container(
            color: Colors.white,
            child: Container(
              color: liveBackground,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                drawer: const NavigationDrawer(),
                // drawerDragStartBehavior: HelperFunctions.isArabic?DragStartBehavior.down:DragStartBehavior.start,
                // drawerDragStartBehavior: HelperFunctions.isArabic?DragStartBehavior.down:DragStartBehavior.start,
/*
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
                  child: const CustomAppBar(
                    back: false,
                    title: null,
                  ),
                ),
*/
                body:   const LiveMainScreen(),


              ),
            ),
          );
      },
      ),);
    }
  }
}
