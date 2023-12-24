import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/forget_password/cubit/states/reset_password_state.dart';
import 'package:creen/features/forget_password/repo/reset_password_repo.dart';
import 'package:creen/features/forget_password/repo/send_code_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(Initial());

  ResetPasswordCubit get(BuildContext ctx) => BlocProvider.of(ctx);

  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<Object?> navTo(BuildContext context, {required String page}) =>
      Navigator.pushNamed(context, page);

  Future<Object?> navReplaceTo(BuildContext context, {required String page}) =>
      Navigator.pushReplacementNamed(context, page);

  void resetPassword(BuildContext context,{required String email,required String code}) {
    if (formKey.currentState!.validate()) {
      // emailController.text
      ResetPasswordRepo.resetPassword(email: email, code: code, password: passwordController.text).then((value) {
        navTo(context, page: RoutePaths.authLogin);
      });
    }
  }
}
