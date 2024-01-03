import 'dart:developer';

import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/cart/viewModel/cart/cart_cubit.dart';
import 'package:creen/features/chat/viewModel/validateStory/validate_story_created_at_cubit.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:creen/features/live/repo/live_destroy_repo.dart';
import 'package:creen/features/market/viewModel/categories/categories_cubit.dart';
import 'package:creen/features/notifications/viewModel/notifications/notifications_cubit.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:creen/features/subject/view/pages/add_subject.dart';
import 'package:creen/features/subject/viewModel/blogs/blogs_cubit.dart';
import 'package:creen/features/subject/viewModel/createBlogs/create_new_blogs_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/utils/widgets/blogs_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BlogsCubit blogsCubit;

  @override
  void initState() {
    if (HelperFunctions.isLoggedIn) {
     /* HelperFunctions.getLiveId().then((value) {
        LiveDestroyRepo.destroyLive(liveId:value );

        return value;
      });*/
      int? id;
      HelperFunctions.getLiveId().then((value){
        id = value;
        log('id id id $id');
        if(id != null){
          LiveDestroyRepo.destroyLive(liveId: id!).then((value){
          });

        }});
      context.read<ValidateStoryCreatedAtCubit>().validateStory();
      context.read<CartCubit>().getMyCart();
      context.read<ProfileCubit>().getProfile(
            context,
          );
      context.read<NotificationsCubit>().getNotificationsCount();
    }
    blogsCubit = context.read<BlogsCubit>()
      ..initController(context)
      ..getBlogs(
        context,
      );
    super.initState();
  }

  @override
  Widget build(

    BuildContext context,
  ) {
    log('token ${HelperFunctions.currentUser?.apiToken} ${GetStorage().read<String>(storageKey + klanguage)}');

    // log('token ${HelperFunctions.isArabic} ');
    print("fayeeeeeeeeeeeeeeeeeeez: ${HelperFunctions.currentUser?.apiToken}");
    return Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
/*
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black45],
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            tileMode: TileMode.clamp,
          ),
*/
        color: Colors.grey
        // image: DecorationImage(image: AssetImage(kAppLogog),fit: BoxFit.cover)
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: Visibility(
            visible: HelperFunctions.isLoggedIn,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: FloatingActionButton(
                onPressed: () {
                  if (!HelperFunctions.validateLogin()) {
                    return;
                  }
                  NavigationService.push(
                      page: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => CategoriesCubit(),
                          ),
                          BlocProvider.value(
                            value: blogsCubit,
                          ),
                          BlocProvider(
                            create: (context) => CreateNewBlogsCubit(),
                          ),
                        ],
                        child: const AddSubjectScreen(),
                      ),
                      isNamed: false);
                },
                backgroundColor: MainStyle.primaryColor,
                child: SvgPicture.asset("assets/images/post.svg",width: MediaQuery.of(context).size.height*.03,color: Colors.white,),
              ),
            ),
          ),
          drawer: const NavigationDrawer(),
          // drawerDragStartBehavior: HelperFunctions.isArabic?DragStartBehavior.down:DragStartBehavior.start,
          // drawerDragStartBehavior: HelperFunctions.isArabic?DragStartBehavior.down:DragStartBehavior.start,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.26),
            child: const CustomAppBar(
              back: false,
              title: null,
              main: true,
              removeBottomBorderColor: true,
            ),
          ),
          body: BlogsView(
            blogsCubit: blogsCubit,
          ),
        ),
      ),
    );
  }
}
