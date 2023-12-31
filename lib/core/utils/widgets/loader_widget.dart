import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: CircularProgressIndicator(
      //   color: color ?? Colors.black,
      // ),
      child: SpinKitFadingCircle(
        color: color ?? Colors.black,
        size: 65.r,
        
      ),
    );
  }
}
