import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

class RadioTile<T> extends StatelessWidget {
  const RadioTile({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.txtColor,
    this.fillColor,
  }) : super(key: key);
  final String title;
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final Color? txtColor, fillColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          fillColor:
              fillColor == null ? null : MaterialStateProperty.all(fillColor),
          activeColor: Colors.black,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(
          title.translate,
          style: TextStyle(
            color: txtColor,
          ),
        ),
      ],
    );
  }
}
