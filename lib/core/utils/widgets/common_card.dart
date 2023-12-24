import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

class CommonCard extends StatelessWidget {
  final Color? color;
  final double? radius,height,elevation,width;
  final Widget? child;

  const CommonCard({Key? key, this.color, this.radius, this.child, this.height, this.elevation, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: MainStyle.shadowColor,
      elevation:  elevation ?? 0 ,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 8),
        side: const BorderSide(
            color: Colors.white),
      ),
      child: SizedBox(height: height??Sizes.screenHeight() * 0.13,
      width: width??Sizes.screenWidth() * 0.45,
        child: child),
    );
  }
}
