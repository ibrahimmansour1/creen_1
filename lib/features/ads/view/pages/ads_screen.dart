import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../viewModel/ads/ads_cubit.dart';
import '../widgets/ads_view.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key}) : super(key: key);
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  late AllAdsCubit adsCubit;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this, initialIndex: 0);
    controller!.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    if (controller!.indexIsChanging) {
      switch (controller!.index) {
        case 0:
          break;
        case 1:
          break;
      }
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TabController? controller =TabController(length: 5, vsync: this, initialIndex: 0);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'ads',
          )),
      floatingActionButton: FloatingActionButton(
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black45],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp)),
          child: Container(
              // width: Sizes.screenWidth(),
              //height: Sizes.screenHeight(),
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: ListView(
                children: [
                  Container(
                      color: Colors.white,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        controller: controller,
                        onTap: (v) {},
                        isScrollable: true,
                        //indicatorPadding: EdgeInsets.only(left: 10),
                        labelPadding: const EdgeInsets.only(left: 8, right: 8),
                        tabs: [
                          Tab(
                            child: Text(
                              'all_ads'.translate,
                              style: MainTheme.authTextStyle.copyWith(
                                  fontSize: 15.r,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'job_ads'.translate,
                              style: MainTheme.authTextStyle.copyWith(
                                  fontSize: 15.r,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'commodity_ads'.translate,
                              style: MainTheme.authTextStyle.copyWith(
                                  fontSize: 15.r,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'services_ads'.translate,
                              style: MainTheme.authTextStyle.copyWith(
                                  fontSize: 15.r,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: Sizes.screenWidth(),
                    height: Sizes.screenHeight(),
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: TabBarView(
                      controller: controller,
                      children: [
                        BlocProvider(
                          create: (context) => AllAdsCubit(),
                          child: const AdView(),
                        ),
                        BlocProvider(
                          create: (context) => AllAdsCubit(categoryId: 1),
                          child: const AdView(),
                        ),
                        BlocProvider(
                          create: (context) => AllAdsCubit(categoryId: 2),
                          child: const AdView(),
                        ),
                        BlocProvider(
                          create: (context) => AllAdsCubit(categoryId: 3),
                          child: const AdView(),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class AdView extends StatefulWidget {
  const AdView({
    super.key,
  });

  @override
  State<AdView> createState() => _AdViewState();
}

class _AdViewState extends State<AdView> {
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
    return BlocBuilder<AllAdsCubit, AllAdsState>(
      builder: (context, state) {
        if (state is AdsLoading) {
          return const LoaderWidget();
        }
        if (adsCubit.ads.isEmpty) {
          return  Center(
            child: Text('no_current_ads'.translate),
          );
        }
        return AdsView(
          ads: adsCubit.ads,
          scrollController: adsCubit.scrollController,
        );
      },
    );
  }
}
