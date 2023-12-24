import 'package:awesome_dialog/awesome_dialog.dart';
export 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:creen/core/utils/extensions/string.dart';

import '../../themes/themes.dart';

class CustomAwesomeDialog {
  Future<void> showDialog({
    required BuildContext context,
    num width = 500,
    DialogType type = DialogType.info,
    required String message,
    void Function()? onPressed,
    Color? confirmBtnColor,
  }) async {
    return AwesomeDialog(
      width: width.r,
      context: context,
      animType: AnimType.scale,
      dialogType: type,
      btnOkText: 'ok'.translate,
      body: Center(
        child: Text(
          message,
          style: MainTheme.authTextStyle.copyWith(
            fontWeight: FontWeight.normal,
            height: 1.1.r,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      btnOkOnPress: onPressed ?? () {},
      btnOkColor: confirmBtnColor,
    ).show();
  }

  Future<void> showOptionsDialog({
    required BuildContext context,
    num width = 500,
    DialogType type = DialogType.info,
    required String message,
    required String btnOkText,
    required String btnCancelText,
    void Function()? onConfirm,
    void Function()? onCancelled,
    Color? confirmBtnColor,
    Color? cancelBtnColor,
  }) async {
    return AwesomeDialog(
      width: width.r,
      context: context,
      animType: AnimType.scale,
      dialogType: type,
      btnOkText: btnOkText.translate,
      btnCancelText: btnCancelText.translate,
      body: Center(
        child: Text(
          message,
          style: MainTheme.authTextStyle.copyWith(
            fontWeight: FontWeight.normal,
            height: 1.1.r,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      btnOkOnPress: onConfirm ?? () {},
      btnCancelOnPress: onCancelled ?? () {},
      btnOkColor: confirmBtnColor,
      btnCancelColor: cancelBtnColor,
    ).show();
  }
}
