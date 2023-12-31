import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlined_text/outlined_text.dart';

class LiveButton extends StatelessWidget {
  const LiveButton({
    Key? key,
    required this.backgroundColor,
    this.fontSize = 15,
    this.radius = 25,
  }) : super(key: key);
  final Color backgroundColor;
  final num radius, fontSize;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: backgroundColor,
        radius: radius.r,
        child: OutlinedText(
          text: Text(
            'Live',
            style: TextStyle(color: Colors.white, fontSize: fontSize.r,fontWeight: FontWeight.bold),
          ),
          // strokes: [
          //   OutlinedTextStroke(
          //     color: Colors.white,
          //     width: 1,
          //   ),
          //   OutlinedTextStroke(
          //     color: Colors.black,
          //     width: 1,
          //   ),
          // ],
        ));
  }
}
