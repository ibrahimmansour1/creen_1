import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultAppBar extends StatelessWidget {
   DefaultAppBar({super.key,required this.txt});

  String? txt;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("assets/images/accountLogo.svg"),
         Text(
          txt!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "Bahij_TheSansArabic",
          ),
        ),
        SvgPicture.asset("assets/images/notifyIcon.svg"),
      ],
    );
  }
}
