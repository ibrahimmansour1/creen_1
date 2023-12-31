import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
   BannerAdWidget({super.key,  this.adSize = const AdSize(width: 468, height: 300)}) ;
 AdSize adSize ;
  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? myBanner;
  AdWidget? adWidget;
  bool showBanner = false;
  late BannerAdListener listener;
  @override
  void initState() {
    listener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        // print('Ad loaded.');
        setState(() {
          showBanner = true;
        });
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        // print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) {
        if (kDebugMode) {
          print('Ad opened.');
        }
      },
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) {
        if (kDebugMode) {
          print('Ad closed.');
        }
      },
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) {
        if (kDebugMode) {
          print('Ad impression.');
        }
      },
    );
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-9259263566568628/8541932861',
      // size:   AdSize.banner,
      size:   widget.adSize,
      request: const AdRequest(),
      listener: listener,
    );
    myBanner?.load().then((value) {
      if (myBanner != null) {
        adWidget = AdWidget(ad: myBanner!);
        return;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    myBanner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !showBanner
        ? const BoxHelper()
        : Container(
            alignment: Alignment.center,
            width: myBanner?.size.width.toDouble(),
            height: myBanner?.size.height.toDouble(),
            child: adWidget,
          );
  }
}
