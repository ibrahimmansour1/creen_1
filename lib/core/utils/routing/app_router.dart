import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/Auth/viewModel/login/login_cubit.dart';
import 'package:creen/features/BMICalculator/view/bmi_main_tab_screen.dart';
import 'package:creen/features/BMICalculator/viewModel/bmiMainTab/bmi_main_tab_cubit.dart';
import 'package:creen/features/ads/model/ad_data.dart';
import 'package:creen/features/ads/viewModel/ads/ads_cubit.dart';
import 'package:creen/features/ads/viewModel/createAd/create_ad_cubit.dart';
import 'package:creen/features/cart/view/cart_details_screen.dart';
import 'package:creen/features/cart/view/cart_screen.dart';
import 'package:creen/features/chat/group_details_screen.dart';
import 'package:creen/features/follow/model/user_following_model.dart';
import 'package:creen/features/forget_password/view/enter_code_view.dart';
import 'package:creen/features/forget_password/view/forget_password_view.dart';
import 'package:creen/features/forget_password/view/reset_password_view.dart';
import 'package:creen/features/global_screens/no_internet_connection_screen.dart';
import 'package:creen/features/home/presentation/pages/main_page.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:creen/features/live/presentation/pages/live_attendance.dart';
import 'package:creen/features/live/presentation/pages/live_chat_screen.dart';
import 'package:creen/features/market/viewModel/allProducts/all_products_cubit.dart';
import 'package:creen/features/profile/presentaion/pages/my_ads_screen.dart';
import 'package:creen/features/profile/presentaion/pages/my_blogs_screen.dart';
import 'package:creen/features/profile/presentaion/pages/my_products_screen.dart';
import 'package:creen/features/splashScreens/presentation/splah_view.dart';
import 'package:creen/features/subject/view/pages/blog_details_screen.dart';
import 'package:creen/features/subject/viewModel/blogDetails/blog_details_cubit.dart';
import 'package:creen/features/subject/viewModel/blogs/blogs_cubit.dart';
import 'package:creen/features/wallets/view/wallet_screen.dart';
import 'package:creen/features/wallets/viewModel/points/points_cubit.dart';
import 'package:creen/features/wallets/viewModel/wallets/wallets_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/Auth/presentation/pages/login.dart';
import '../../../features/Auth/presentation/pages/register.dart';
import '../../../features/Auth/viewModel/register/register_cubit.dart';
import '../../../features/addressData/viewModel/addressData/address_data_cubit.dart';
import '../../../features/ads/view/pages/ad_details_screen.dart';
import '../../../features/ads/view/pages/general_ad.dart';
import '../../../features/ads/viewModel/viewPromotion/view_promotion_cubit.dart';
import 'navigation_transitions.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //Core
      case RoutePaths.coreSplash:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );

      case RoutePaths.coreNoInternet:
        final args = settings.arguments as Map?;
        return MaterialPageRoute(
          builder: (_) => NoInternetConnection(
            fromSplash: args?['fromSplash'],
          ),
          settings: settings,
        );

      //Auth
      case RoutePaths.authLogin:
        return NavigationFadeTransition(
          BlocProvider(
            create: (_) => LoginCubit(),
            child: const LoginScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.authRegister:
        return NavigationFadeTransition(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => RegisterCubit(),
              ),
              BlocProvider(
                create: (context) => AddressDataCubit(),
              ),
            ],
            child: const RegisterScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.myProducts:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AllProductsCubit(
              userId: settings.arguments as int?,
            ),
            child:  MyProductsScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.myAds:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => AllAdsCubit(
                    userId: settings.arguments as int?,
                  ),
              child: const MyAdsScreen()),
          settings: settings,
        );
      case RoutePaths.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
          settings: settings,
        );
      case RoutePaths.cartDetails:
        return MaterialPageRoute(
          builder: (_) =>  CartDetailsScreen(customer: settings.arguments as Map<String,dynamic>,),
          settings: settings,
        );
      case RoutePaths.viewAd:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => ViewPromotionCubit(
                  promotionId: settings.arguments as int?,
                ),
              ),
            ],
            child: const AdDetailsScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.createAds:
        return MaterialPageRoute(
          builder: (_) {
            var arguments = settings.arguments as Map<String, dynamic>;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CreateAdCubit(
                    ad: arguments['ad'] as AdData?,
                  ),
                ),
                BlocProvider.value(
                  value: arguments['all_ads_cubit'] as AllAdsCubit,
                ),
              ],
              child: const GeneralAdScreen(),
            );
          },
          settings: settings,
        );
      case RoutePaths.myBlogs:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BlogsCubit(userId: settings.arguments as int?),
            child: const MyBlogsScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.blogDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                BlogDetailsCubit(blogId: settings.arguments as int?),
            child: const BlogDetailsScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.bmiTabs:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BmiMainTabCubit(),
            child: const BmiMainTabScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.groupDetails:
        return MaterialPageRoute(
          builder: (_) => const GroupDetailScreen(),
          settings: settings,
        );
      case RoutePaths.myWallets:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => WalletsCubit(),
              ),
              BlocProvider(
                create: (_) => PointsCubit(),
              ),
            ],
            child: const WalletScreen(),
          ),
          settings: settings,
        );
      case RoutePaths.liveAttendance:
        return MaterialPageRoute(builder: (context)=> LiveAttendance(users: settings.arguments as List<LiveUser>,));
      case RoutePaths.liveChat:
        Map<String, dynamic> arguments = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context)=> LiveChatScreen(user: arguments['user'] as UserFollowers,liveCreator: (arguments['liveCreator'] as bool), creator: arguments['creator']as UserFollowers,));

    case RoutePaths.forgetPassword:
        // Map<String, dynamic> arguments = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context)=>  const ForgetPasswordView());

    case RoutePaths.enterCode:
        Map<String, dynamic> arguments = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context)=>  EnterCodeView(email: arguments['email'],));

    case RoutePaths.resetPassword:
        Map<String, dynamic> arguments = settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context)=>  ResetPasswordView(email: arguments['email'], code: arguments['code'],));


      //Home
      case RoutePaths.mainPage:
        final int? args = settings.arguments as int?;
        return NavigationFadeTransition(
          MainPage(
            index: args,
          ),
          settings: settings,
        );

      //Profile
      // case RoutePaths.getMoneyScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const GetMoneyScreen(),
      //     settings: settings,
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );
    }
  }
}
