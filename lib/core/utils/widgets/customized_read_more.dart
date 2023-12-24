import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../themes/themes.dart';

class CustomizedReadMore extends StatelessWidget {
  const CustomizedReadMore(
      {Key? key,
      required this.data,
      this.txtColor = Colors.black,
      this.maxLines = 4})
      : super(key: key);

  final String? data;
  final Color txtColor;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      '${data ?? ''}\n',
      trimLines: maxLines,
      colorClickableText: Colors.blue,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'show_more'.translate,
      trimExpandedText: 'show_less'.translate,
      style: MainTheme.authTextStyle.copyWith(
          color: txtColor, fontSize: 16.r, fontWeight: FontWeight.normal),
      moreStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
