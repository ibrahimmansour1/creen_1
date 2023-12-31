import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart';

class CodeTextField extends StatelessWidget {
   CodeTextField({super.key, required this.controller, required this.currentFocus, this.nextFocus,  this.autoFocus = false});
 TextEditingController controller;
 FocusNode currentFocus;
  FocusNode? nextFocus;
final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: 1,
      focusNode: currentFocus,
      autofocus: autoFocus ,
      textAlign: TextAlign.center,
      cursorColor: Colors.white,
      onChanged: (txt) {
        currentFocus.unfocus();
        if(nextFocus != null) {
          nextFocus!.requestFocus();
        }
      },
      style: const TextStyle(color: Colors.white),
      validator: (txt) {
        if (txt!.isEmpty) {
          return 'empty'.translate;
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(4)),
          constraints: BoxConstraints(
            minWidth: size.width * 0.1,
            maxWidth: size.width * 0.1,
            minHeight:
                size.height * MediaQuery.devicePixelRatioOf(context) * 0.15,
            maxHeight:
                size.height * MediaQuery.devicePixelRatioOf(context) * 0.15,
          ),
          contentPadding: EdgeInsets.zero),
    );
  }
}
