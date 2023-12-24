import 'package:flutter/material.dart';

class LiveDetailsGridViewItem extends StatelessWidget {
   LiveDetailsGridViewItem({
    super.key,
    required this.liveImage,
    required this.profileImage,
    required this.name,
    required this.once,
    required this.video,
  });

  final String liveImage;
  final String profileImage;
  final String name;
  final bool once;
  Widget Function() video;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(

        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: const Alignment(0, 0.8),
        decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(liveImage), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.grey.shade500.withOpacity(0.4),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                textDirection: TextDirection.ltr,
                children: [
                  SizedBox(
                    width: 112.4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: once ? 20 : null,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(profileImage),
                    radius: once ? 40 : 22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
