import 'dart:developer';

import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/features/live/presentation/pages/live_screen.dart';
import 'package:creen/features/live/viewModel/live/live_main_cubit.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:creen/features/videos/viewModel/videos/videos_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/live_button.dart';

class CustomBottomNavigationbBar extends StatefulWidget {
  final Function onTap;
  final int inx;
  // final ProfileCubit prC;
  const CustomBottomNavigationbBar({
    Key? key,
    required this.onTap,
    required this.inx,
    // required this.prC,
  }) : super(key: key);

  @override
  CustomBottomNavigationbBarState createState() =>
      CustomBottomNavigationbBarState();
}

class CustomBottomNavigationbBarState
    extends State<CustomBottomNavigationbBar> {
  int inxShop = 1;
  late ProfileCubit pro ;
  @override
  void initState() {
    pro = context.read<ProfileCubit>()..getProfile(context,bottomNavigationBarindication: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // print("pro ${pro.profileData?.profile}");
    log('HelperFunctions.currentUser?.profile ${HelperFunctions.currentUser?.profile}');
    return SizedBox(
      height: (widget.inx==2?76:68).r,
      child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          iconSize: 30.r,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedLabelStyle: MainTheme.authTextStyle
              .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
          unselectedLabelStyle: MainTheme.authTextStyle
              .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
          unselectedIconTheme: const IconThemeData(
            color: MainStyle.navigationColor,
          ),
          unselectedItemColor: Colors.black,
          selectedItemColor: widget.inx == 1 ? Colors.red : Colors.black,
          // selectedIconTheme: IconThemeData(
          //   color: widget.inx == 1 ? Colors.red : Colors.black,
          // ),
          // iconSize: 25.r,
          currentIndex: widget.inx,
          type: BottomNavigationBarType.fixed,
          backgroundColor: widget.inx == 1 ? Colors.transparent : Colors.white,
          onTap: (index) {
setState(() {
  liveIndex = 0;

});

          if (index > 1 && !HelperFunctions.validateLogin()) {
              return;
            }
            if (index == 2) {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const LiveScreen()));
              // HelperFunctions.showComingSoonDialog(context);
              // return;
            }
            setState(() {
              inxShop = index;
            });
            widget.onTap(index);
          },
          items: [
            const BottomNavigationBarItem(
              // icon: ImageIcon(
              //   AssetImage('assets/images/main.png'),
              // ),
              icon: Icon(
                Icons.home,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                height: 35.r,
                width: 35.r,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    if (!HelperFunctions.validateLogin()) {
                      return;
                    }
                    // NavigationService.push(
                    //     page: const AddVideoScreen(), isNamed: false);
                    context.read<VideosCubit>().addNewVideo();
                  },
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.play_circle_fill_outlined,
              ),
              label: '',
            ),
             BottomNavigationBarItem(
              activeIcon: LiveButton(
                backgroundColor: Colors.red,
                radius: 14.r,
              ),
              icon: LiveButton(
                backgroundColor: Colors.white,
                radius: 14.r,
                fontSize: 12,
              ),
              // icon: Image.asset(
              //   ('assets/images/khater.png'),
              //   fit: BoxFit.cover,
              //   height: 45.r,
              //   width: 45.r,
              // ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded),
              // icon: ImageIcon(AssetImage('assets/images/market.png')),
              label: '',
            ),
             BottomNavigationBarItem(
              icon:  /*((HelperFunctions.currentUser?.profile == null)
                  ?
              // const ImageIcon(AssetImage(personProfile))
                  :*/CircleAvatar(
                radius: 14.r,
                backgroundImage: (HelperFunctions.currentUser?.profile == null)
                  ?
              // const ImageIcon(AssetImage(personProfile))
                  const AssetImage(personProfile):NetworkImage(HelperFunctions.currentUser?.profile)as ImageProvider<Object>,backgroundColor: Colors.transparent,) ,
              // icon: ImageIcon(AssetImage('assets/images/profile.png')),
              label: '',
            ),
          ]),
    );
  }
}
