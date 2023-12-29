import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../whatsapp_home.dart';

class StoryItem extends StatelessWidget {
   const StoryItem({
    Key? key,
    required this.seen,
    required this.profileImage,
    required this.userName,
    this.profileImageSize = 26,
    this.textColor = Colors.white,
    required this.ColorValue,
  }) : super(key: key);
  final bool seen;
  final String ? profileImage;
  final String userName;
  final Color textColor;
  final num profileImageSize;
  final int ColorValue ;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 27.r*2,
      // height: 90,
      margin: const EdgeInsets.symmetric(horizontal: 5),

      alignment: Alignment.center,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Container(
             width: 26.r*2,
             height: 26.r*2,
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               border: Border.all(color: Colors.primaries[ColorValue],width: 2),
               image: DecorationImage(
                 image: image(profileImage),
                 fit: BoxFit.cover,
               )
             ),

           ),
          const SizedBox(height: 5),
          Text(
            userName,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
