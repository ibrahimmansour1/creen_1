import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/validations/auth_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';

import '../../repo/contact_us_repo.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var messageController = TextEditingController();

  Future<void> contactUs() async {
    var validate = formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    emit(ContactUsLoading());
    try {
      var contactUsData = await ContactUsRepo.submitMessage(
        body: {
          'name': nameController.text,
          'message': messageController.text,
          if (emailController.text.isNotEmpty) ...{
            'email': emailController.text,
          },
          if (emailController.text.isNotEmpty) ...{
            'mobile': mobileController.text,
          },
        },
      );
      if (contactUsData == null) {
        Fluttertoast.showToast(
          msg: 'network'.translate,
          backgroundColor: Colors.red,
        );
        emit(ContactUsError());
        return;
      }
      if (contactUsData.status == true) {
        Fluttertoast.showToast(
          msg: contactUsData.message ?? '',
          backgroundColor: Colors.green,
        );
        emit(ContactUsDone());
        _clearFields();
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'something_wrong'.translate,
        backgroundColor: Colors.red,
      );
      emit(ContactUsError());
    }
  }

  String? emailValidator(String? value) {
    // if (value!.isEmpty) {
    //   return null;
    // }
    return AuthValidator.emailValidator(value);
  }

  String? phoneValidator(String? value) {
    // if (value!.isEmpty) {
    //   return null;
    // }
    return AuthValidator.phoneValidator(value);
  }

  String? messageValidator(String? value) {
    if (value!.isEmpty) {
      return 'message_required';
    }
    return null;
  }

  void _clearFields() {
    nameController.clear();
    emailController.clear();
    mobileController.clear();
    messageController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    messageController.dispose();
    return super.close();
  }
}
