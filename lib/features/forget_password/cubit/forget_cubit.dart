import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/forget_password/cubit/states/forget_state.dart';
import 'package:creen/features/forget_password/repo/send_code_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(Initial());

  ForgetPasswordCubit get(BuildContext ctx) => BlocProvider.of(ctx);

  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<Object?> navTo(BuildContext context, {required String page}) =>
      Navigator.pushNamed(context, page,arguments: {'email':emailController.text});

  Future<Object?> navReplaceTo(BuildContext context, {required String page}) =>
      Navigator.pushReplacementNamed(context, page);

  void sendCode(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // emailController.text
      SendCodeRepo.sendCode(email: emailController.text).then((value) {
        navTo(context, page: RoutePaths.enterCode);
      });
    }
  }
}
