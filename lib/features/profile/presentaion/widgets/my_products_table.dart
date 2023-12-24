import 'dart:math';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/widgets/customized_table.dart';
import '../../../../core/utils/widgets/register_button.dart';
import '../../../../core/utils/widgets/table_text.dart';

class MyProductsTable extends StatelessWidget {
  const MyProductsTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomizedTable(
      // defaultColumnWidth: const IntrinsicColumnWidth(),
      columnWidths: {
        0: FlexColumnWidth(20.r),
        1: FlexColumnWidth(20.r),
        2: FlexColumnWidth(20.r),
        3: FlexColumnWidth(30.r),
      },
      tableRow: [
         TableRow(
          children: [
            TableText(
              title: 'the_image'.translate,
            ),
            TableText(
              title: 'name'.translate,
            ),
            TableText(
              title: 'price'.translate,
            ),
            TableText(
              title: 'operations'.translate,
            ),
          ],
        ),
        ...List.generate(
          10,
          (index) => TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(15.r),
                child: Image.asset(
                  'assets/images/product.jpg',
                ),
              ),
              TableText(
                title: '${'pro'.translate} ${index + 1}',
              ),
              TableText(
                title: '${Random().nextInt(1000)}',
              ),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (_) => [
                  HelperFunctions.buildPopupMenu(
                    icons: FontAwesomeIcons.penSquare,
                    title: 'edit',
                  ),
                  HelperFunctions.buildPopupMenu(
                    icons: Icons.star,
                    title: 'show',
                  ),
                  HelperFunctions.buildPopupMenu(
                    icons: Icons.ads_click_outlined,
                    title: 'promote',
                  ),
                  HelperFunctions.buildPopupMenu(
                    icons: Icons.delete,
                    title: 'delete',
                  ),
                ],
                child: const RegisterButton(
                  color: Colors.green,
                  removeBorderColor: true,
                  textSize: 25,
                  title: 'operations',
                  radius: 10,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
