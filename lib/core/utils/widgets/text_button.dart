import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

class CustomTextButton extends StatelessWidget {
  final String? title;
  final bool? send, follow;
  final bool? icon;
  final double? width, radius, height;
  final void Function()? function;
  final Widget? child;
  final Color? backgroundColor;
  const CustomTextButton({
    Key? key,
    required this.title,
    required this.function,
    this.width,
    this.radius,
    this.height,
    this.send,
    this.icon,
    this.child,
    this.follow,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Sizes.screenHeight() * 0.07,
      width: width ?? Sizes.screenWidth() * 0.23,
      child: TextButton(
        onPressed: function,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10)),
          shadowColor: MainStyle.shadowColor,
          backgroundColor: backgroundColor ??
              (follow == true ? Colors.red : MainStyle.primaryColor),
        ),
        child: Container(
          alignment: Alignment.topCenter,
          child: send == true
              ? Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title!.isEmpty ? '' : title!.translate,
                        style: MainTheme.authTextStyle
                            .copyWith(color: Colors.white, fontSize: 16),
                        //textAlign: TextAlign.start,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 15,
                        ),
                        child: Icon(Icons.send, color: Colors.white, size: 15),
                      ),
                    ],
                  ),
                )
              : icon == true
                  ? child
                  : Center(
                    child: Text(
                        title!.isEmpty ? '' : title!.translate,
                        style: MainTheme.authTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        //textAlign: TextAlign.start,
                      ),
                  ),
        ),
      ),
    );
  }
}
