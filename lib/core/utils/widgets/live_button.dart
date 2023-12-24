import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlined_text/outlined_text.dart';

class LiveButton extends StatelessWidget {
  const LiveButton({
    Key? key,
    required this.backgroundColor,
    this.fontSize = 15,
    this.radius = 20,
  }) : super(key: key);
  final Color backgroundColor;
  final num radius, fontSize;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: (radius + 2).r,
      backgroundColor: Colors.black38,
      child: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: radius.r,
          child: OutlinedText(
            text: Text(
              'Live',
              style: TextStyle(color: Colors.white, fontSize: fontSize.r),
            ),
            strokes: [
              OutlinedTextStroke(
                color: Colors.white,
                width: 1,
              ),
              OutlinedTextStroke(
                color: Colors.black,
                width: 3,
              ),
            ],
          )),
    );
  }
}
