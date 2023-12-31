import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/screen_utitlity.dart';
import '../../themes/themes.dart';

class TableText extends StatelessWidget {
  const TableText({
    Key? key,
    required this.title,
    this.textSp = 13,
    this.decoration,
    this.verticalPadding = 15,
    this.horizontalPadding = 8.0,
    this.textAlign,
    this.fontWeight,
    this.textOverflow,
    this.maxLines,
  }) : super(key: key);

  final String title;
  final num textSp, verticalPadding, horizontalPadding;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.r, vertical: verticalPadding.r),
      child: Text(
        title.translate,
        textAlign: textAlign ?? TextAlign.center,
        maxLines: maxLines,
        overflow: textOverflow,
        style: MainTheme.subTextStyleLite.copyWith(
          decoration: decoration,
          fontWeight: fontWeight,
          color: MainStyle.tableTextColor,
          fontSize: ScreenUtil().setSp(
            textSp,
          ),
        ),
      ),
    );
  }
}
