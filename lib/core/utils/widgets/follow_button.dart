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
    return InkWell(
      onTap: onPressed,
      child: Container(
        // title: '',
        // function: onPressed,
        // radius: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isFollow ? Colors.transparent : Colors.red,
        ),
        height: 26.r,
        width: 49.r,
        // icon: true,
        // follow: isFollow,
        // backgroundColor:
        child: Center(
          child: Text(
            (!isFollow ? 'follow' : 'follower').translate,
            style: MainTheme.authTextStyle.copyWith(
              color: !isFollow ? Colors.white : Colors.red,
              fontSize: 14.r,
              fontWeight: isFollow ? FontWeight.bold : FontWeight.normal,
            ),
            //textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
