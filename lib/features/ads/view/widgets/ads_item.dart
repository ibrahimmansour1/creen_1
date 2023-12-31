import 'package:creen/core/themes/themes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';

import '../../../../core/themes/screen_utitlity.dart';

class AdsItem extends StatelessWidget {
  final String? text, content;
  final bool? isMessage;
  final bool? mobile;
  final Widget? widget;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final void Function(String)? onChanged;
  const AdsItem(
      {Key? key,
      this.text,
      this.controller,
      this.validator,
      this.isMessage,
      this.content,
      this.mobile,
      this.onChanged,
      this.hintText,
      this.widget,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            text!,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: Sizes.screenWidth() * 0.9,
          padding: const EdgeInsets.only(right: 10, left: 10),
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 18),
          decoration: BoxDecoration(
              border: Border.all(color: MainStyle.navigationColor),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: widget ??
              TextFormField(
                controller: controller,
                onChanged: onChanged,
                maxLines: isMessage! ? 10 : 1,
                minLines: isMessage! ? 4 : 1,
                textDirection: TextDirection.rtl,
                cursorColor: Colors.black,
                keyboardType: keyboardType ??
                    (mobile == true ? TextInputType.phone : TextInputType.text),
                textAlign: TextAlign.right,
                // textInputAction: TextInputAction.search,
                style: MainTheme.fieldStyle,
                validator: validator,
                //  ??
                //     (value) {
                //       if (value!.isEmpty) {
                //         return "this field is required";
                //       }
                //       if (text == 'Email' && !value.contains('@')) {
                //         return "this email not valid";
                //       }
                //       return null;
                //     },
                decoration: InputDecoration(
                  hintText: hintText?.translate ?? '',
                  errorStyle: const TextStyle(color: Colors.red),
                  hintStyle: const TextStyle(color: MainStyle.navigationColor),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.only(left: 15, bottom: 15, top: 15),
                ),
                initialValue: content != null?content!.translate:null,
              ),
        ),
      ],
    );
  }
}
