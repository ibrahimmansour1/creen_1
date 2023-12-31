import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/screen_utitlity.dart';

class CustomizedTable extends StatelessWidget {
  const CustomizedTable({
    Key? key,
    required this.tableRow,
    this.columnWidths,
    this.border,
    this.horizontalPadding = 15,
    this.defaultColumnWidth = const FlexColumnWidth(),
  }) : super(key: key);
  final List<TableRow> tableRow;
  final Map<int, TableColumnWidth>? columnWidths;
  final TableBorder? border;
  final num horizontalPadding;
  final TableColumnWidth defaultColumnWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(horizontalPadding),
      ),
      child: Table(
        defaultColumnWidth: defaultColumnWidth,
        columnWidths: columnWidths ??
            {
              0: FixedColumnWidth(
                ScreenUtil().setWidth(90),
              ),
              1: FixedColumnWidth(
                ScreenUtil().setWidth(150),
              ),
              2: FixedColumnWidth(
                ScreenUtil().setWidth(90),
              ),
            },
        border: border ??
            TableBorder.all(
              color: MainStyle.lightGreyColor,
            ),
        children: tableRow,
      ),
    );
  }
}
