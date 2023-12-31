import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';
import '../../utils/responsive/sizes.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.removePadding = false,
    this.icon,
    this.color,
    this.radius = 30,
    this.textSize,
    this.removeBorderColor = false,
  }) : super(key: key);
  final String title;
  final void Function()? onPressed;
  final bool removePadding;
  final bool removeBorderColor;
  final Widget? icon;
  final Color? color;
  final double radius;
  final num? textSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: removePadding
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 5.r, vertical: 10.r),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: Sizes.screenHPaddingMedium(),
        child: ElevatedButton.icon(
          icon: icon ?? const SizedBox(),
          label: FittedBox(
            child: Text(
              title.translate,
              style: color == Colors.white
                  ? MainTheme.appBarTextStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: textSize?.r,
                    )
                  : MainTheme.appBarTextStyle.copyWith(
                      fontSize: textSize?.r,
                    ),
            ),
          ),
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              removeBorderColor
                  ? BorderSide.none
                  : BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                color ?? Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
