import 'dart:io';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/loader_widget.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({
    super.key,
    required this.videoUrl,
  });
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getThumbnail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BoxHelper(
            width: 110.r,
            height: 110.r,
            child: const LoaderWidget(
              color: Colors.white,
            ),
          );
        }
        if (snapshot.hasError) {
          return Text(
            'something_wrong'.translate,
          );
        }
        return Stack(
          children: [
            BoxHelper(
              height: 110,
              width: 110,
              child: Image.file(
                File(snapshot.data ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.play_circle_outline_outlined,
                color: Colors.white,
                size: 60.r,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> getThumbnail() async {
    return VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 110
          .r
          .toInt(), // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
  }
}
