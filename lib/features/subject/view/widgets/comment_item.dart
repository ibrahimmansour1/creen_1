import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/functions/helper_functions.dart';

class CommentItem extends ConsumerWidget {
  final int? userId;
  final String? text, image, name;
  final Function() deleteIconTap;
  final Function() editingIconTap;
  final Function() reportIconTap;

  const CommentItem({
    this.userId,
    this.name,
    this.text,
    this.image,
    required this.deleteIconTap,
    required this.editingIconTap,
    required this.reportIconTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white,
              backgroundImage: image == null || image?.isEmpty == true
                  ? const AssetImage(personProfile)
                  : NetworkImage(image ?? '') as ImageProvider,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              //alignment: Alignment.topRight,
              width: Sizes.screenWidth() * 0.65,
              padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
              decoration: const BoxDecoration(
                  color: MainStyle.shareColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border(
                      bottom: BorderSide(color: Color(0xffE7E7E7)),
                      left: BorderSide(color: Color(0xffE7E7E7)),
                      right: BorderSide(color: Color(0xffE7E7E7)),
                      top: BorderSide(color: Color(0xffE7E7E7)))),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? '',
                    ),
                    Text(
                      text ?? '',
                    )
                  ],
                ),
              ),
            ),
            /*InkWell(
              onTap: () {
                deleteIconTap();
              },
              child: Icon(Icons.more_horiz),
            ),*/
            Expanded(
              child: PopupMenuButton(
                onSelected: (value) {
                  if (value == 'delete') {
                    deleteIconTap();
                  } else if (value == 'edit') {

                print("edit");
                editingIconTap();

                  }
                  else if(value == 'report'){
                    print("report");
                    reportIconTap();
                  }
                },
                position: PopupMenuPosition.under,
                itemBuilder: (_) {
                  var isMe = userId ==
                      HelperFunctions.currentUser?.id;

                  return [
                    if (isMe) ...[
                      HelperFunctions.buildPopupMenu(
                        icons: Icons.delete,
                        title: 'delete',
                        value: 'delete',
                      ),

                    HelperFunctions.buildPopupMenu(
                      icons: Icons.edit,
                      title: 'edit',
                      value: 'edit',
                    ),]
                    else ...[
                      HelperFunctions.buildPopupMenu(
                        icons: Icons.report,
                        title: 'report',
                        value: 'report',
                      ),
                    ],
                  ];
                },
                child: Icon(Icons.more_horiz),
              ),
            ),

          ],
        ),
      ),
    );
    // Container(

    //   decoration: const BoxDecoration(
    //       color: MainStyle.shareColor,
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(30),
    //       ),
    //       border: Border(
    //           bottom: BorderSide(color: Color(0xffE7E7E7)),
    //           left: BorderSide(color: Color(0xffE7E7E7)),
    //           right: BorderSide(color: Color(0xffE7E7E7)),
    //           top: BorderSide(color: Color(0xffE7E7E7)))),

    // );
  }
}
