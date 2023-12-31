import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/screen_utitlity.dart';
import '../../../../core/themes/themes.dart';

class CustomizedWalletCard extends StatelessWidget {
  const CustomizedWalletCard({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.r, vertical: 10.r),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: MainStyle.lightGreyColor.withOpacity(0.4),
            padding: EdgeInsets.all(10.r),
            child: Text(
              title.translate,
              style: MainTheme.appBarTextStyle.copyWith(
                fontSize: 16.r,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.r,
              horizontal: 10.r,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
