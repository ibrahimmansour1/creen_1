// ignore_for_file: deprecated_member_use

import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/custom_option_dialog.dart';
import 'package:creen/features/follow/viewModel/following/following_cubit.dart';
import 'package:creen/features/global_screens/popup_page.dart';
import 'package:creen/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:creen/features/market/viewModel/allProducts/all_products_cubit.dart';
import 'package:creen/features/market/viewModel/reaction/reaction_cubit.dart';
import 'package:creen/features/profile/presentaion/pages/my_profile.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:creen/features/subject/view/pages/home_screen.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/widgets/chat_screen.dart';
import '../../../follow/viewModel/followers/followers_cubit.dart';
import '../../../live/presentation/pages/live_screen.dart';
import '../../../live/viewModel/live/live_main_cubit.dart';
import '../../../market/view/pages/main_market_screen.dart';
import '../../../videos/presentaion/pages/video_screen.dart';

class MainPage extends ConsumerWidget {
  final int? index;
  MainPage({
    Key? key,
    this.index,
  }) : super(key: key);
  final StateProvider<int> _bottomNavIndexProvider =
      StateProvider<int>(((ref) => 0));
  final StateProvider<String> appBartitleProvider =
      StateProvider<String>(((ref) => 'الرئيسية'));

  final List<Widget> widgets = [
    const HomeScreen(),
    const VideoScreen(),
    const LiveScreen(),
   /* BlocProvider(
      create: (_) => AdsCubit(),
      child: const ReflectionScreen(),
    ),*/
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AllProductsCubit(),
        ),
        BlocProvider(
          create: (context) => ReactionCubit(),
        ),
      ],
      child:  MainMarketScreen(),
      // child: const MarketScreen(),
    ),
    MultiBlocProvider(
      key: ValueKey(HelperFunctions.currentUser?.id),
      providers: [
        BlocProvider(
          create: (_) => ProfileCubit(userId: HelperFunctions.currentUser?.id),
        ),

        BlocProvider(
          create: (_) => FollowingCubit(),
        ),
        BlocProvider(
          create: (_) => FollowersCubit(),
        ),
      ],
      child: MyProfileScreen(
        key: ValueKey(HelperFunctions.currentUser?.id),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int bottomNavIndex = ref.watch(_bottomNavIndexProvider);
    String? appBartitle = ref.watch(appBartitleProvider);
    if (index != null) {
      ref.read(_bottomNavIndexProvider.state).state = index!;
    }
    return bottomNavIndex == 0
        ? Directionality(
          textDirection: HelperFunctions.isArabic?TextDirection.rtl:TextDirection.ltr,
          child: PageView(
              controller: PageController(initialPage: 0, viewportFraction: 1),
              scrollDirection: Axis.horizontal,
              children: [
                buildPopUpPage(context, bottomNavIndex, ref, appBartitle),
                const AllConversationsScreen(),
              ],
            ),
        )
        : buildPopUpPage(context, bottomNavIndex, ref, appBartitle);
  }

  PopUpPage buildPopUpPage(BuildContext context, int bottomNavIndex,
      WidgetRef ref, String? appBartitle) {
    return PopUpPage(
        onWillPop: () async {
          return await showDialog(
              context: context,
              useSafeArea: true,
              builder: (context) => CustomOptionDialog(
                    title: ('do_you_want_to_log_out').translate,
                    function: () => SystemNavigator.pop(),
                  ));
        },
        showAppbar: false,

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: bottomNavIndex != 1||(liveIndex==0&&bottomNavIndex==2)
            ? const SizedBox()
            : BottomAppBar(
                color: Colors.transparent,
                child: CustomBottomNavigationbBar(
                  onTap: (v) {
                    ref.read(_bottomNavIndexProvider.state).state = v;
                    if (bottomNavIndex == 0) {
                      ref.read(appBartitleProvider.state).state = 'الرئيسية';
                      debugPrint(appBartitle);
                    } else if (bottomNavIndex == 1) {
                      ref.read(appBartitleProvider.state).state = 'الفيديوهات';
                    } else if (bottomNavIndex == 2) {
                      ref.read(appBartitleProvider.state).state = 'الإعلانات';
                    } else if (bottomNavIndex == 3) {
                      ref.read(appBartitleProvider.state).state = 'التسوق';
                    } else {
                      ref.read(appBartitleProvider.state).state = 'البروفايل';
                    }
                  },
                  inx: bottomNavIndex,
                ),
              ),
        appBartitle: (bottomNavIndex == 0
                ? 'Creen - كرين'
                : bottomNavIndex == 1
                    ? 'videos'
                    : bottomNavIndex == 2
                        ? 'live'
                        : bottomNavIndex == 3
                            ? 'shopping'
                            : 'my_profile')
            .translate,
        bottomNavigationBar: bottomNavIndex == 1||(liveIndex==1&&bottomNavIndex == 2)
            ? const SizedBox()
            : BottomAppBar(
                color: Colors.transparent,
                child: CustomBottomNavigationbBar(
                  onTap: (v) {
                    ref.read(_bottomNavIndexProvider.state).state = v;
                    if (bottomNavIndex == 0) {
                      ref.read(appBartitleProvider.state).state = 'الرئيسية';
                      debugPrint(appBartitle);
                    } else if (bottomNavIndex == 1) {
                      ref.read(appBartitleProvider.state).state = 'الفيديوهات';
                    } else if (bottomNavIndex == 2) {
                      ref.read(appBartitleProvider.state).state = 'الإعلانات';
                    } else if (bottomNavIndex == 3) {
                      ref.read(appBartitleProvider.state).state = 'التسوق';
                    } else {
                      ref.read(appBartitleProvider.state).state = 'البروفايل';
                    }
                  },
                  inx: bottomNavIndex,
                ),
              ),
        child: widgets[bottomNavIndex]);
  }
}
