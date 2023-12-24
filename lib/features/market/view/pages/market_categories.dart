import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:creen/features/market/view/pages/sections/specific_product_section.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sections/products_categories_view.dart';

class MarketCategScreen extends StatefulWidget {
  const MarketCategScreen({Key? key}) : super(key: key);
  @override
  _MarketCategScreenState createState() => _MarketCategScreenState();
}

class _MarketCategScreenState extends State<MarketCategScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    controller = TabController(length: 5, vsync: this, initialIndex: 0);
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
            title: 'shopping_categories',
          )),
      body: Directionality(
        textDirection: localization.currentLanguage.toString() == "en"
            ? TextDirection.ltr
            : TextDirection.rtl,
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
              // padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              padding: EdgeInsets.only(
                top: 10.r,
                left: 10.r,
                right: 10.r,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(20),
                //     topRight: Radius.circular(20)),
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
                        labelStyle: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 16.r,
                          fontWeight: FontWeight.bold,
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
                              'categories'.translate,
                              // style: MainTheme.authTextStyle.copyWith(
                              //     // fontSize: 14.r,
                              //     fontWeight: FontWeight.normal),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'latest_products'.translate,
                              // style: MainTheme.authTextStyle.copyWith(
                              //     // fontSize: 14.r,
                              //     fontWeight: FontWeight.normal),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'special_products'.translate,
                              // style: MainTheme.authTextStyle.copyWith(
                              //     // fontSize: 14.r,
                              //     fontWeight: FontWeight.normal),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'my_likes'.translate,
                              // style: MainTheme.authTextStyle.copyWith(
                              //     // fontSize: 14.r,
                              //     fontWeight: FontWeight.normal),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'offers'.translate,
                              // style: MainTheme.authTextStyle.copyWith(
                              //     // fontSize: 14.r,
                              //     fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: Sizes.screenWidth(),
                    height: Sizes.screenHeight(),
                    //margin: const EdgeInsets.only(top: 30,bottom: 20),
                    padding: EdgeInsets.only(
                      bottom: Sizes.screenHeight() * 0.14,
                    ),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      children: const [
                        ProductsCategoriesView(),
                        SpecificProductSection(
                          key: ValueKey('all'),
                          section: 'all',
                        ),
                        SpecificProductSection(
                          key: ValueKey('special'),
                          section: 'special',
                        ),

                        SpecificProductSection(
                          key: ValueKey('likes_products'),
                          section: 'likes_products',
                        ),
                        SpecificProductSection(
                          key: ValueKey('offers'),
                          section: 'offers',
                        ),
                        // Container(),
                        // Container(),
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
