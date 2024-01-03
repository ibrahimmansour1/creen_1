import 'dart:developer';

import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/contactUs/presentaion/pages/contact_us.dart';
import 'package:creen/features/contactUs/viewModel/contactUs/contact_us_cubit.dart';
import 'package:creen/features/drawer/presentaion/pages/privacy.dart';
import 'package:creen/features/drawer/presentaion/pages/terms_and_conditions_screen.dart';
import 'package:creen/features/drawer/presentaion/widgets/drawer_item.dart';
import 'package:creen/features/live/repo/live_checkuser_repo.dart';
import 'package:creen/features/live/repo/live_destroy_repo.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:creen/features/localization/screen/language_select.dart';
import 'package:creen/features/localization/viewModel/lang/lang_cubit.dart';
import 'package:creen/features/market/view/pages/market_categories.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:creen/features/start_live/presentation/pages/main_start_live.dart';
import 'package:creen/features/videos/presentaion/pages/add_video.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/routing/route_paths.dart';
import '../../../../core/utils/widgets/chat_screen.dart';
import '../../../../core/utils/widgets/live_button.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: localization.currentLanguage.toString() == "en"
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Material(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  bottom: 30,
                ),
                padding: EdgeInsets.fromLTRB(20, Sizes.screenHeight() * 0.08,
                    20, Sizes.screenHeight() * 0.05),
                color: MainStyle.primaryColor,
                child: Visibility(
                  visible: HelperFunctions.isLoggedIn,
                  replacement: Text(
                    'welcome'.translate,
                    style:
                        MainTheme.authTextStyle.copyWith(color: Colors.white),
                  ),
                  child: DrawerHeader(
                    profileCubit: context.read<ProfileCubit>(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
                child: Column(
                  children: !HelperFunctions.isLoggedIn
                      ? [
                          DrawerItem(
                            name: 'login',
                            icon: const ImageIcon(
                              AssetImage('assets/images/1.png'),
                            ),
                            onPressed: () => NavigationService.push(
                                page: RoutePaths.authLogin, isNamed: true),
                          ),
                        ]
                      : [
                          DrawerItem(
                            name: 'shopping_categories',
                            icon: const ImageIcon(
                              AssetImage('assets/images/1.png'),
                            ),
                            onPressed: () => NavigationService.push(
                                page: const MarketCategScreen(),
                                isNamed: false),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                            name: 'chats',
                            icon: Image(
                              image: const AssetImage(
                                  'assets/images/chat_icon.png'),
                              // color: Colors.black,
                              height: 27.r,
                              width: 27.r,
                            ),
                            onPressed: () {
                              if (!HelperFunctions.validateLogin()) {
                                return;
                              }
                              NavigationService.push(
                                page: const AllConversationsScreen(),
                                isNamed: false,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                              name: 'videos',
                              icon: const Icon(Icons.play_circle_fill_outlined),
                              onPressed: () {
                                if (!HelperFunctions.validateLogin()) {
                                  return;
                                }
                                NavigationService.push(
                                    page: const UserVideoScreen(),
                                    isNamed: false);
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                            name: 'live',
                            icon: const LiveButton(
                              backgroundColor: Colors.red,
                              radius: 14,
                              fontSize: 12, textColor: Colors.white,
                            ),
                            onPressed: () {
                             /* (HelperFunctions.getLiveId()).then((value){
                                log('get Live Id $value');

                              });*/
                              // log(' HelperFunctions.getLiveId() ${HelperFunctions.getLiveId()}');
                              int? id;
                              HelperFunctions.getLiveId().then((value){
                                id = value;
                                log('id id id $id');
                                if(id != null){
                                  LiveDestroyRepo.destroyLive(liveId: id!).then((value){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=> MainStartLive()));
                                  });

                                }else{
                                  log('log log');
                                  LiveCheckUserRepo.checkUser()
                                      .then((value){
                                    log('value $value');
                                    if(value != null) {
                                      if(!value){
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=> MainStartLive()));
                                      }
                                      else{
                                        Fluttertoast.showToast(msg: 'لا يمكن انشاء اكثر من بث لنفس المستخدم في نفس الوقت');
                                      }
                                    }
                                    else{
                                      Fluttertoast.showToast(msg: 'فشل التحقق يرجى المحاوله مره أخرى');
                                    }
                                  });
                                }

                              });

                              // return HelperFunctions.showComingSoonDialog(context);
                            },
                            // onPressed: () => NavigationService.push(
                            //   page: RoutePaths.createAds,
                            //   isNamed: true,
                            // ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                              name: 'change_language',
                              icon: const Icon(
                                Icons.language,
                                size: 20,
                              ),
                              onPressed: () => NavigationService.push(
                                  page: BlocProvider(
                                    create: (context) => LangCubit(),
                                    child: const LanguageSelect(),
                                  ),
                                  isNamed: false)),
                          const SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                              name: 'privacy_policy',
                              icon: const ImageIcon(
                                  AssetImage('assets/images/5.png')),
                              onPressed: () => NavigationService.push(
                                  page: const PrivacyScreen(), isNamed: false)),
                          const SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                              name: 'terms',
                              icon: const ImageIcon(
                                  AssetImage('assets/images/6.png')),
                              onPressed: () => NavigationService.push(
                                  page: const TermsAndConditionsScreen(),
                                  isNamed: false)),
                          const SizedBox(
                            height: 10,
                          ),
                          DrawerItem(
                              name: 'contact_us',
                              icon: const ImageIcon(
                                  AssetImage('assets/images/7.png')),
                              onPressed: () => NavigationService.push(
                                  page: BlocProvider(
                                    create: (context) => ContactUsCubit(),
                                    child: const ContactUsScreen(),
                                  ),
                                  isNamed: false)),
                        ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    Key? key,
    required this.profileCubit,
  }) : super(key: key);
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const LoaderWidget();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.white,
              backgroundImage: HelperFunctions.currentUser?.profile == null
                  ?  const AssetImage(personProfile)
                  : NetworkImage(HelperFunctions.currentUser!.profile)
                      as ImageProvider,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      profileCubit.profileData?.name ?? '',
                      // profileCubit.profileData?.name ?? 'عبد الرحمن',
                      style: MainTheme.appBarTextStyle),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      HelperFunctions.currentUser?.email ?? '',
                      // profileCubit.profileData?.email ?? 'aboda@gmail.com',
                      overflow: TextOverflow.fade,
                      style: MainTheme.appBarTextStyle)
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
