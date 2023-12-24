import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxHelper extends StatelessWidget {
  const BoxHelper({
    Key? key,
    this.height,
    this.width,
    this.child,
  }) : super(key: key);
  final num? height, width;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.r,
      width: width?.r,
      child: child,
    );
  }
}
