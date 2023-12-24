import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/profile/presentaion/widgets/ad_item.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/screen_utitlity.dart';
import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/routing/route_paths.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../ads/viewModel/ads/ads_cubit.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  late AllAdsCubit adsCubit;

  @override
  void initState() {
    adsCubit = context.read<AllAdsCubit>()
      ..initController()
      ..getAllAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: const CustomAppBar(
          title: 'my_ads',
          back: true,
        ),
      ),
      floatingActionButton: BlocBuilder<AllAdsCubit, AllAdsState>(
        builder: (context, state) {
          return Visibility(
            visible: adsCubit.isMyAds,
            child: FloatingActionButton(
              onPressed: () {
                NavigationService.push(
                  page: RoutePaths.createAds,
                  isNamed: true,
                  arguments: {
                    'all_ads_cubit': context.read<AllAdsCubit>(),
                  },
                );
              },
              backgroundColor: MainStyle.primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        },
      ),
      body: BlocBuilder<AllAdsCubit, AllAdsState>(
        builder: (context, state) {
          if (state is AdsLoading) {
            return const LoaderWidget(
              color: Colors.white,
            );
          }
          if (adsCubit.ads.isEmpty) {
            return Center(
              child: Text(
                'no_ads'.translate,
                style: MainTheme.authTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            controller: adsCubit.scrollController,
            itemCount: adsCubit.ads.length,
            itemBuilder: (context, index) {
              var ad = adsCubit.ads[index];
              return AdItem(
                ad: ad,
                title: ad.text?.content ?? '',
                clicks: ad.clicks?.toString() ?? '',
                adImage: ad.image?.url ?? '',
                views: ad.seen?.toString() ?? '',
                adId: ad.id ?? 0,
              );
            },
          );
          // return SingleChildScrollView(
          //   child: Column(
          //     children: List.generate(
          //       10,
          //       (index) => const AdItem(),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
