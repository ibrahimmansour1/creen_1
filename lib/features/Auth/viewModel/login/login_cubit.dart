import 'dart:developer';

import 'package:creen/core/themes/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/custom_dialog.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:equatable/equatable.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/routing/route_paths.dart';
import '../../repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitial());

  String accountType = Account.email.name;
  var emailOrPhoneController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login(
    BuildContext context,
  ) async {
    var validate = formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }

    emit(LoginLoading());
    String? token = '';
    try {
      token = await FCMConfig.instance.messaging.getToken();
    } catch (_) {}
    try {
      if(!emailOrPhoneController.text.trim().startsWith('0') && !emailOrPhoneController.text.trim().contains('@')) {
        emailOrPhoneController.text = '0${emailOrPhoneController.text}';
      }
      var loginData = await LoginRepo.loginUser(body: {
        'email': emailOrPhoneController.text.trim(),
        'password': passwordController.text.trim(),
        'fcm_token': token,
      });
      if (loginData == null) {
        return;
      }
      log("loginData.message    =====> ${loginData.message?.toLowerCase()}");
      // print("loginData.status ==> ${loginData.status}");
      if (loginData.status == true) {

        Fluttertoast.showToast(
          msg: loginData.message?.toLowerCase().translate ?? '',
        );
        await HelperFunctions.storeUserData(loginData.data);
        accountType = Account.email.name;
        await HelperFunctions.account(accountType);
        NavigationService.pushAndRemoveUntil(
          page: RoutePaths.mainPage,
          isNamed: true,
          predicate: (p0) => false,
        );
        emit(LoginDone());
      } else {
        emit(LoginError());
        if(context.mounted) {
          showDialog(
          context: context,
          builder: (_) => CustomDialog(
            title: loginData.message?.toLowerCase().translate ?? '',
            widget: [
              SizedBox(
                width: Sizes.screenWidth() * 0.3,
                child: CustomTextButton(
                  title: 'ok',
                  function: () {
                    NavigationService.goBack();
                  },
                ),
              ),
            ],
          ),
        );
        }
      }
    } catch (e) {
      log('$e', name: 'error_login');
      emit(LoginError());
      Fluttertoast.showToast(
        msg: 'something_wrong'.translate,
        backgroundColor: Colors.red,
      );
    }
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'email_or_phone_required'.translate;
    }
    // if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value.trim()) &&
    //     int.tryParse(value) == null) {
    //   return 'بريد إلكتروني غير صالح';
    // }
    // if (int.tryParse(value) != null && value.length > 12 || value.length < 9) {
    //   return 'رقم هاتف غير صالح';
    // }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'password_required'.translate;
    }
    return null;
  }

  @override
  Future<void> close() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
