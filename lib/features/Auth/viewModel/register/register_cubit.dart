import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/Auth/repo/register_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  String _gender = '-';
  String get gender => _gender;

  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  int? cityId;

  void onChanged(String? value) {
    if (value == null) {
      return;
    }
    _gender = value;
    emit(RadioValueStateChanged(
      groupValue: _gender,
    ));
  }

  Future<void> register() async {
    var validate = formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }
    emit(RegisterLoading());
    var token = await FCMConfig.instance.messaging.getToken();
    var registerData = await RegisterRepo.registerUser(
      body: {
        'name': nameController.text,
        'mobile': phoneController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'address': addressController.text.isEmpty?",":addressController.text,
        'gender': _gender=='-'?"female":_gender,
        'age': ageController.text.isEmpty?"1":ageController.text,
        'city_id': cityId,
        'fcm_token': token,
      },
    );
    if (registerData == null) {
      emit(RegisterError());
      Fluttertoast.showToast(
        msg: 'network'.translate,
        backgroundColor: Colors.red,
      );
      return;
    }
    if (registerData.status == true) {
      Fluttertoast.showToast(
        msg: registerData.message ?? '',
      );
      emit(RegisterDone());
      await HelperFunctions.storeUserData(
        registerData.data,
      );
      NavigationService.pushAndRemoveUntil(
        page: RoutePaths.mainPage,
        predicate: (_) => false,
        isNamed: true,
      );
    } else {
      emit(RegisterError());
      String message = '';
      if (registerData.message != null) {
        message = registerData.message ?? '';
      } else if (registerData.errorMessages != null) {
        registerData.errorMessages?.forEach((key, value) {
          message += '${value[0]} \n';
        });
      }
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();

    return super.close();
  }
}
