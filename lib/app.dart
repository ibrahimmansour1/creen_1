
import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'core/utils/constants.dart';
import 'core/utils/routing/app_router.dart';
import 'core/utils/routing/navigation_service.dart';
import 'core/utils/routing/route_paths.dart';
import 'core/utils/services_initializer.dart';
import 'features/Auth/viewModel/deleteAccount/delete_account_cubit.dart';
import 'features/Auth/viewModel/logout/logout_cubit.dart';
import 'features/BMICalculator/viewModel/bmiCalc/bmi_calc_cubit.dart';
import 'features/cart/viewModel/addToCart/add_to_cart_cubit.dart';
import 'features/cart/viewModel/cart/cart_cubit.dart';
import 'features/chat/viewModel/validateStory/validate_story_created_at_cubit.dart';
import 'features/follow/viewModel/follow/follow_cubit.dart';
import 'features/localization/manager/app_localization.dart';
import 'features/market/viewModel/productsCategories/products_categories_cubit.dart';
import 'features/notifications/viewModel/notifications/notifications_cubit.dart';
import 'features/profile/viewModel/profile/profile_cubit.dart';
import 'features/subject/viewModel/blogs/blogs_cubit.dart';
import 'features/videos/viewModel/videos/videos_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ValidateStoryCreatedAtCubit()),
        BlocProvider(
          create: (context) => BmiCalcCubit(),
        ),
        BlocProvider(
          create: (context) => BlogsCubit(),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => FollowCubit(),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
        BlocProvider(
          create: (_) => VideosCubit(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteAccountCubit(),
        ),
        BlocProvider(
          create: (_) => NotificationsCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCategoriesCubit(),
        ),
      ],
      child: FutureBuilder(
          future: ServiceInitializer.instance.initializeFlutterFire(),
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              return Center(
                child: Text('${"error".translate}: ${snapShot.error}'),
              );
            } else {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  // For both Android + iOS
                  statusBarColor: Colors.transparent,
                  // For apps with a light background:
                  // For Android (dark icons)
                  statusBarIconBrightness: Brightness.dark,
                  // For iOS (dark icons)
                  statusBarBrightness: Brightness.light,
                ),
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: MaterialApp(
                      navigatorKey: NavigationService.navigationKey,
                      builder: (context, widget) {
                        return ScreenUtilInit(
                          useInheritedMediaQuery: true,
                          builder: (_, w) => widget!,
                        );
                      },
                      useInheritedMediaQuery:
                          true, // Set to true_device_preview
                      localizationsDelegates: const [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      locale: localization.locale,
                      supportedLocales: localization.supportedLocales(),
                      debugShowCheckedModeBanner: false,
                      title: 'Creen - كرين',
                      theme: appTheme,
                      initialRoute: RoutePaths.coreSplash,
                      onGenerateRoute: AppRouter.generateRoute,
                    )),
              );
            }
          }),
    );
  }
}
