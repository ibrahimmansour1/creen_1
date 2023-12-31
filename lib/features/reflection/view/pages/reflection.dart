import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/app_loader.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:creen/features/reflection/viewModel/ads/ads_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/themes/themes.dart';
import '../../../ads/view/widgets/custom_ad.dart';

class ReflectionScreen extends StatefulWidget {
  const ReflectionScreen({Key? key}) : super(key: key);

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> {
  late AdsCubit adsCubit;

  @override
  void initState() {
    adsCubit = context.read<AdsCubit>()..getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: false,
            title: 'live',
          )),
      //backgroundColor: Colors.amber,
      body: BlocBuilder<AdsCubit, AdsState>(
        builder: (context, state) {
          if (state is AdsLoading) {
            return const AppLoader();
          }
          if (adsCubit.ads.isEmpty) {
            return Center(
              child: Text(
                'no_ideas'.translate,
                style: MainTheme.authTextStyle.copyWith(fontSize: 16),
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: List.generate(
                  adsCubit.ads.length,
                  (index) {
                    var ad = adsCubit.ads[index];
                    return CustomAdCard(
                      adsImage: ad.image,
                      adsTitle: ad.title,
                      // location: ad.,
                      timesAgo: ad.createdAt == null
                          ? null
                          : timeAgo.format(
                              ad.createdAt!,
                              locale: 'eg',
                            ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
