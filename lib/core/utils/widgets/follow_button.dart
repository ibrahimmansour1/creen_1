import 'dart:developer';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    Key? key,
    required this.isFollow,
    required this.onPressed,
  }) : super(key: key);

  final bool isFollow;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    log('fowwol $isFollow');
    return isFollow ?SizedBox():InkWell(
      onTap: onPressed,
      child:  Container(
        // title: '',
        // function: onPressed,
        // radius: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.r),
          color:  Colors.red,
        ),

        // icon: true,
        // follow: isFollow,
        // backgroundColor:
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(5.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add,color: Colors.white,size: 15.r,),
                SizedBox(width: 3.w,),
                Text(
                  ('follow').translate,
                  style: MainTheme.authTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14.r,
                    fontWeight: FontWeight.bold,
                  ),
                  //textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
