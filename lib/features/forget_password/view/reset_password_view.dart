import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/register_text_field.dart';
import 'package:creen/features/forget_password/cubit/reset_password_cubit.dart';
import 'package:creen/features/forget_password/cubit/states/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordView extends StatelessWidget {
   ResetPasswordView({super.key, required this.email, required this.code});
  final String email;
  final String code;
late ResetPasswordCubit resetPasswordCubit;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (BuildContext context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit,ResetPasswordStates>(listener: (BuildContext context, state) {  }, builder: (BuildContext context, ResetPasswordStates state) {
        resetPasswordCubit = ResetPasswordCubit().get(context);
        return Scaffold(
          backgroundColor: liveBackground,
          body: SizedBox(
            width: size.width,
            child: Form(
              key: resetPasswordCubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RegisterTextField(
                    controller: resetPasswordCubit.passwordController,
                    type: TextInputType.emailAddress,
                    label:
                    // 'enter email',
                    'ادخل كلمه سر جديده',
                    validator: (txt){
                      if(txt!.isEmpty) {
                        return 'Empty Field';
                      }
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: ()=>resetPasswordCubit.resetPassword(context, email: email, code: code),
                    child: Container(
                      width: Sizes.screenWidth() * 0.7,
                      height: Sizes.screenHeight() * 0.07,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      alignment: Alignment.center,
                      color: Colors.green,
                      child: const Text(
                        // 'Send Code',
                        'أنشئ كلمه سر جديده',

                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),

/*
                  InkWell(
                    onTap: () => forgetPasswordCubit.sendCode(context),
                    child: Container(
                      width: Sizes.screenWidth() * 0.7,
                      height: Sizes.screenHeight() * 0.07,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3)),
                      child: Text(
                        // 'Send Code',
                        'طلب كود جديد',
                        textDirection:
                        localization.currentLanguage.toString() == 'en'
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
*/
                ],
              ),
            ),
          ),
        );
      },),
    );
  }
}
