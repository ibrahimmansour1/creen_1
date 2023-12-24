import 'dart:developer';

import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/features/forget_password/cubit/code_cubit.dart';
import 'package:creen/features/forget_password/cubit/states/code_state.dart';
import 'package:creen/features/forget_password/view/widgets/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterCodeView extends StatelessWidget {
  EnterCodeView({super.key, required this.email});
final String email;
  late CodeCubit codeCubit;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (BuildContext context) => CodeCubit(),
      child: BlocConsumer<CodeCubit, CodeState>(
        listener: (BuildContext context, state) {
          if (state is Initial) {
            log('focus1');
            codeCubit.focus1.requestFocus();
          }
        },
        builder: (BuildContext context, CodeState state) {
          codeCubit = CodeCubit().get(context);
          return Scaffold(
            backgroundColor: liveBackground,
            body: SafeArea(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Form(
                  key: codeCubit.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: [
                          CodeTextField(
                            controller: codeCubit.digit1,
                            currentFocus: codeCubit.focus1,
                            nextFocus: codeCubit.focus2,
                            autoFocus: true,
                          ), CodeTextField(
                            controller: codeCubit.digit2,
                            currentFocus: codeCubit.focus2,
                            nextFocus: codeCubit.focus3,
                          ), CodeTextField(
                            controller: codeCubit.digit3,
                            currentFocus: codeCubit.focus3,
                            nextFocus: codeCubit.focus4,
                          ), CodeTextField(
                            controller: codeCubit.digit4,
                            currentFocus: codeCubit.focus4,
                            nextFocus: codeCubit.focus5,
                          ), CodeTextField(
                            controller: codeCubit.digit5,
                            currentFocus: codeCubit.focus5,
                            nextFocus: codeCubit.focus6,
                          ), CodeTextField(
                            controller: codeCubit.digit6,
                            currentFocus: codeCubit.focus6,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: ()=>codeCubit.checkCode(context, email: email),
                        child: Container(
                          width: Sizes.screenWidth() * 0.7,
                          height: Sizes.screenHeight() * 0.07,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          alignment: Alignment.center,
                          color: Colors.green,
                          child: const Text(
                            // 'Send Code',
                            'ارسل الكود',

                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      /*     RegisterTextField(
                      controller: forgetPasswordCubit.emailController,
                      type: TextInputType.emailAddress,
                      validator: (txt){
                        if(txt!.isEmpty) {
                          return 'Empty Field';
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: () => forgetPasswordCubit.sendCode(context),
                      child: Container(
                        width: Sizes.screenWidth() * 0.7,
                        height: Sizes.screenHeight() * 0.07,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Text(
                          'Send Code',
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
                    ),*/
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
