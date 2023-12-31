import '../extensions/string.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

import '../responsive/sizes.dart';

class RegisterTextField extends StatelessWidget {
  final String? label, errorText, hint, prefixCode;
  final IconData? icon;
  final TextInputType? type;
  final ValueChanged<String>? onChange;
  final bool? edit, enabled, visibility;
  final Function? onChangeCountry, onInit;
  final TextEditingController? controller;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final bool obsecureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool register;
  final bool isStatus;

  const RegisterTextField({
    Key? key,
    this.label,
    this.icon,
    this.type,
    this.hint,
    this.errorText,
    this.onChange,
    this.edit,
    this.enabled,
    this.visibility,
    this.onChangeCountry,
    this.onInit,
    this.controller,
    this.validator,
    this.obsecureText = false,
    this.fillColor,
    this.suffixIcon,
    this.maxLines = 1,
    this.register = false,
    this.prefixCode,
    this.isStatus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.screenWidth() * 0.7,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        enabled: enabled ?? true,
        textAlign: TextAlign.center,
        keyboardType: type,
        onFieldSubmitted: (v) {},
        onChanged: onChange,
        maxLines: maxLines,
        validator: validator,
        style: TextStyle(color: register ? Colors.black : Colors.white),
        decoration: InputDecoration(
          filled: fillColor == null ? false : true,
          fillColor: fillColor ?? Colors.white,
          suffixText: prefixCode,

          /* prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.all(0),
                  child: Icon(
                    icon,
                    color: Colors.grey,
                    size: 20,
                  ),
                )
              : null,*/
          suffixIcon: suffixIcon,
          /* label: Center(
            child: Text(
              "${label==null?"":label!.translate}",
              textDirection: localization.currentLanguage.toString() == 'en'
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              textAlign: TextAlign.center,
              style:  const TextStyle(
                color:*/ /* register?Colors.black:*/ /*Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),*/

          // labelText: label?.translate,
          alignLabelWithHint: true,
/*
          labelStyle: const TextStyle(
            color: MainStyle.mainGray,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
*/
          errorText: errorText,
          hintText: "${label == null ? "" : label!.translate}",
          hintStyle: TextStyle(
            color: register ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          hintTextDirection: localization.currentLanguage.toString() == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          // hintText: hint?.translate ?? '',

          floatingLabelBehavior: hint != null
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.all(
            10,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: isStatus
                ? const BorderRadius.horizontal(
                    right: Radius.circular(30), left: Radius.circular(30))
                : const BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: isStatus
                ? const BorderRadius.horizontal(
                right: Radius.circular(30), left: Radius.circular(30))
                : const BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedErrorBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: isStatus
                ? const BorderRadius.horizontal(
                right: Radius.circular(30), left: Radius.circular(30))
                : const BorderRadius.all(Radius.circular(4.0)),
          ),
          disabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: isStatus
                ? const BorderRadius.horizontal(
                right: Radius.circular(30), left: Radius.circular(30))
                : const BorderRadius.all(Radius.circular(4.0)),
          ),
          enabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: isStatus
                ? const BorderRadius.horizontal(
                right: Radius.circular(30), left: Radius.circular(30))
                : const BorderRadius.all(Radius.circular(4.0)),
          ),
          errorBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: isStatus
                ? const BorderRadius.horizontal(
                right: Radius.circular(30), left: Radius.circular(30))
                : const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
    );
  }
}
