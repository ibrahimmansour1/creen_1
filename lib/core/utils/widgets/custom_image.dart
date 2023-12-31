import 'dart:io';

import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/videos/presentaion/pages/video_item.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    this.boxFit = BoxFit.cover,
    this.pickedImage,
    this.networkImage,
    this.onRemoved,
    this.isVideo = false,
    this.responsiveHeight = 75,
    this.responsiveWidth = 75,
    this.horizontalPadding = 15,
    this.verticalPadding = 10,
    this.responsiveRadius = 15,
  }) : super(key: key);
  final File? pickedImage;
  final bool isVideo;
  final BoxFit boxFit;
  final String? networkImage;
  final num responsiveHeight,
      responsiveWidth,
      verticalPadding,
      horizontalPadding,
      responsiveRadius;

  final void Function()? onRemoved;

  @override
  Widget build(BuildContext context) {
    var size = Size(responsiveWidth.r, responsiveHeight.h);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.r, vertical: verticalPadding.r),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              responsiveRadius.r,
            ),
            child: isVideo && pickedImage != null
                ? SizedBox(
                    height: size.height,
                    width: size.width,
                    child: VideoItem(
                      videoUrl: pickedImage?.path ?? '',
                    ),
                  )
                : pickedImage == null
                    ? Image.network(
                        networkImage!,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/product.jpg',
                          height: size.height,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                        fit: boxFit,
                        height: size.height,
                        width: size.width,
                      )
                    : Image.file(
                        pickedImage!,
                        fit: BoxFit.cover,
                        height: size.height,
                        width: size.width,
                      ),
          ),
          Positioned(
            top: -ScreenUtil().setHeight(5),
            right: -ScreenUtil().setHeight(5),
            left: -ScreenUtil().setHeight(5),
            child: Visibility(
              visible: onRemoved != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onRemoved,
                    child: CircleAvatar(
                      radius: ScreenUtil().radius(10),
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.close,
                        size: ScreenUtil().radius(14),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
