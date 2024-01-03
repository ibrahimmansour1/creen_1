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
import 'package:flutter_svg/flutter_svg.dart';

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
  late ProfileCubit pro;

  @override
  void initState() {
    pro = context.read<ProfileCubit>()
      ..getProfile(context, bottomNavigationBarindication: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("pro ${pro.profileData?.profile}");
    log('HelperFunctions.currentUser?.profile ${HelperFunctions.currentUser?.profile}');
    return SizedBox(
      //Fayez edit this
      child: BottomNavigationBar(
          elevation: 10,
          currentIndex: widget.inx,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor:  widget.inx==1?Colors.transparent:Colors.white,
          onTap: (index) {
            setState(() {
              liveIndex = 0;
            });

            if (index > 1 && !HelperFunctions.validateLogin()) {
              return;
            }
            if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LiveScreen()));
              // HelperFunctions.showComingSoonDialog(context);
              // return;
            }
            setState(() {
              inxShop = index;
            });
            widget.onTap(index);
          },
          items: [
            BottomNavigationBarItem(
              // icon: ImageIcon(
              //   AssetImage('assets/images/main.png'),
              // ),
              icon: SvgPicture.asset(
                "assets/images/home.svg",
                color:widget.inx == 1?Colors.white: widget.inx == 0 ? Colors.black : Colors.grey[600],
                width: MediaQuery.of(context).size.height * .04,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: GestureDetector(
                onTap: (){
                  if (!HelperFunctions.validateLogin()) {
                    return;
                  }
                  // NavigationService.push(
                  //     page: const AddVideoScreen(), isNamed: false);
                  context.read<VideosCubit>().addNewVideo();
                },
                child: SvgPicture.asset(
                    "assets/images/video_add.svg",
                    color: Colors.white,
                    width: MediaQuery.of(context).size.height * .04,
                  ),
              ),

              icon: SvgPicture.asset(
                "assets/images/video.svg",
                color: Colors.grey[600],
                width: MediaQuery.of(context).size.height * .04,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: LiveButton(
                backgroundColor: Colors.red,
                radius: 14.r, textColor: Colors.white,
              ),
              icon: LiveButton(
                backgroundColor:widget.inx == 1?Colors.white:Colors.grey[600]!,
                radius: 15.r,
                fontSize: 10, textColor: widget.inx == 1?Colors.black:Colors.white,
              ),
              // icon: Image.asset(
              //   ('assets/images/khater.png'),
              //   fit: BoxFit.cover,
              //   height: 45.r,
              //   width: 45.r,
              // ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/bag.svg",
                color: widget.inx == 1?Colors.white:widget.inx == 3 ? Colors.black : Colors.grey[600],
                width: MediaQuery.of(context).size.height * .04,
              ),
              // icon: ImageIcon(AssetImage('assets/images/market.png')),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:  /*((HelperFunctions.currentUser?.profile == null)
                  ?
              // const ImageIcon(AssetImage(personProfile))
                  :*/CircleAvatar(
                radius: 15.r,
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
