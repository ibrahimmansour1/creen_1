import 'package:creen/core/themes/themes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

class CustomDialog extends StatelessWidget {
  final String? title;
  final List<Widget> widget;
  const CustomDialog({Key? key, required this.title, required this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        title!,
        textAlign: TextAlign.center,
        style: MainTheme.authTextStyle.copyWith(color: Colors.black),
      ),
      actions: widget,
    );
  }
}
