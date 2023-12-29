import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/features/ads/view/pages/ads_screen.dart';
import 'package:creen/features/chat/components/home_components/components/story_screen_ui.dart';
import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:creen/features/notifications/view/pages/notification.dart';
import 'package:creen/features/notifications/viewModel/notifications/notifications_cubit.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../features/ads/viewModel/ads/ads_cubit.dart';
import '../../themes/themes.dart';
import '../routing/navigation_service.dart';
import 'chat_screen.dart';
StoriesCubit? storiesCubit;

class CustomAppBar extends StatefulWidget {
  final String? title;
  final bool? back, centerTitle;
  final PreferredSizeWidget? bottom;
  final bool removeBottomBorderColor;
  final bool main;

   const CustomAppBar({
    Key? key,
    required this.title,
    required this.back,
    this.removeBottomBorderColor = false,
    this.centerTitle = true,
    this.bottom,
    this.main = false,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // StoriesCubit? storiesCubit;
@override
  void initState() {
  storiesCubit = StoriesCubit()
    ..initListener()
    ..getStories().then((value){
      log('stories loaded');
      // log('storiesCubit?.stories ${storiesCubit?.stories[0].name}');
    });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var notificationsCubit = context.read<NotificationsCubit>();
// log('storiesCubit ${storiesCubit?.stories[0].id}');
    return BlocProvider<StoriesCubit>.value(value: storiesCubit!,child: Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Container(
        height: Sizes.screenHeight() * 0.15,
          decoration: BoxDecoration(
            border: widget.removeBottomBorderColor
                ? const Border()
                : const Border(
              bottom: BorderSide(color: Colors.green, width: 1.5),
            ),
            color: Colors.black,
            // gradient: const LinearGradient(
            //     colors: [Colors.black, Colors.black45],
            //     begin: Alignment.bottomRight,
            //     end: Alignment.topLeft,
            //     tileMode: TileMode.clamp),
          ),
          child: widget.back == false
              ? Column(
                children: [
                  AppBar(

                              backgroundColor: Colors.black,
                              bottom: widget.bottom,
                              centerTitle: widget.centerTitle,

                              title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                              icon: SvgPicture.asset(
                                        "assets/images/menu.svg",
                                        width: MediaQuery.of(context).size.height *
                                            .035,
                                        color: Colors.white,
                                      ),
                                    ),
                            const BoxHelper(
                              width: 15,
                            ),
                            IconButton(
                              onPressed: () {
                                if (!HelperFunctions.validateLogin()) {
                                  return;
                                }
                                NavigationService.push(
                                    page: const NotificationScreen(),
                                    isNamed: false);
                              },
                              icon: Badge(
                                badgeStyle: BadgeStyle(
                                  padding: EdgeInsets.all(1.4.r),
                                  shape: BadgeShape.instagram,
                                ),
                                position:
                                BadgePosition.topEnd(end: -5.r, top: 1.r),
                                badgeContent: Text(
                                  '${notificationsCubit.notificationsCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                showBadge:
                                notificationsCubit.notificationsCount > 0,
                                child: SvgPicture.asset(
                                  "assets/images/bell.svg",
                                  width: MediaQuery.of(context).size.height *
                                      .035,
                                  color: Colors.white,
                                ),
                              ),
                              iconSize: 32.r,
                            ),
                          ],
                        ),
                        widget.title == null
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 4.r,
                                left: HelperFunctions.currentLanguage ==
                                    'ar'
                                    ? 4.r
                                    : 0,
                                right:
                                HelperFunctions.currentLanguage !=
                                    'ar'
                                    ? 4.r
                                    : 0,
                              ),
                              child: Image.asset(
                                'assets/images/logoo.png',
                                height: 70.r,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )
                            : Text(
                          widget.title!.translate,
                          style: MainTheme.appBarTextStyle,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.r),
                              child: InkWell(
                                onTap: () {
                                  if (!HelperFunctions.validateLogin()) {
                                    return;
                                  }
                                  NavigationService.push(
                                    page: const AllConversationsScreen(),
                                    isNamed: false,
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/images/chat.svg",
                                  width: MediaQuery.of(context).size.height *
                                      .035,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const BoxHelper(
                              width: 25,
                            ),
                            InkWell(
                                onTap: () {
                                  // HelperFunctions.showComingSoonDialog(context);
                                  // return;
                                  if (!HelperFunctions.validateLogin()) {
                                    return;
                                  }
                                  NavigationService.push(
                                    page: BlocProvider(
                                        create: (context) => AllAdsCubit(),
                                        child: const AdsScreen()),
                                    isNamed: false,
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/images/announcement.svg",
                                  width: MediaQuery.of(context).size.height *
                                      .035,
                                  color: Colors.white,
                                ),),
                          ].reversed.toList(),
                        ),
                      ],
                    ),

                  ],
                              ),
                              leading: const SizedBox(),
                              leadingWidth: 0,
                            ),
                  // if(StoriesCubit() != null && widget.main) Expanded(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal:15.r),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         StoryScreenUI(
                  //           storiesCubit: storiesCubit!,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              )
              : AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: widget.centerTitle,
            title: Text(
              widget.title!.translate,
              style: MainTheme.appBarTextStyle,
            ),
            leading: IconButton(
              onPressed: () {
                NavigationService.goBack();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
            //leadingWidth: 0,
          )),
    ),);
  }
}
