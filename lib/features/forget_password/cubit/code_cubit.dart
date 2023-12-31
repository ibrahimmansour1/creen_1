import 'dart:developer';

import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/forget_password/cubit/states/code_state.dart';
import 'package:creen/features/forget_password/repo/check_code_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeCubit extends Cubit<CodeState>{
  CodeCubit():super(Initial());


  CodeCubit get(BuildContext context)=> BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  TextEditingController digit1 =TextEditingController();
  TextEditingController digit2 =TextEditingController();
  TextEditingController digit3 =TextEditingController();
  TextEditingController digit4 =TextEditingController();
  TextEditingController digit5 =TextEditingController();
  TextEditingController digit6 =TextEditingController();
  FocusNode focus1=FocusNode();
  FocusNode focus2=FocusNode();
  FocusNode focus3=FocusNode();
  FocusNode focus4=FocusNode();
  FocusNode focus5=FocusNode();
  FocusNode focus6=FocusNode();
  Future<Object?> navTo(BuildContext context, {required String page}) =>
      Navigator.pushNamed(context, page);

  Future<Object?> navReplaceTo(BuildContext context, {required String page,required Map<String,dynamic>arg}) =>
      Navigator.pushReplacementNamed(context, page,arguments: arg);

  String formTheCode()=>digit1.text+digit2.text+digit3.text+digit4.text+digit5.text+digit6.text;

  void checkCode(BuildContext context,{required String email}) {
    if (formKey.currentState!.validate()) {
      // emailController.text
      CheckCodeRepo.checkCode(code: formTheCode(), email:email ).then((value) {
        log('email $email');
        navReplaceTo(context, page: RoutePaths.resetPassword, arg: {'email':email,'code':formTheCode()});
      });
    }
  }

}