import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTheme {
  static final subTextStyleLite = TextStyle(
    fontSize: ScreenUtil().setSp(11),
    color: MainStyle.newGreyColor.withOpacity(0.3),
  );
  static final fieldStyle = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    // color: MainStyle.newGreyColor.withOpacity(0.3),

  );
  static TextStyle authTextStyle =  TextStyle(
      fontSize: 22.r,
      fontWeight: FontWeight.bold,
      color: MainStyle.primaryColor,
      fontFamily: 'Arial');
  static TextStyle appBarTextStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Arial');
}
