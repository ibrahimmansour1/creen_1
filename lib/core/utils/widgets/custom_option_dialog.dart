import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import '../routing/navigation_service.dart';

class CustomOptionDialog extends StatelessWidget {
  final String title;
  final void Function() function;
  const CustomOptionDialog(
      {Key? key, required this.title, required this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: MainTheme.authTextStyle.copyWith(color: Colors.black),
      ),
      actions: [
        SizedBox(
          width: Sizes.screenWidth() * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextButton(
                title: ('no'),
                function: () {
                  NavigationService.goBack();
                },
              ),
              CustomTextButton(
                title: ('yes'),
                function: function,
              )
            ],
          ),
        )
      ],
    );
  }
}
