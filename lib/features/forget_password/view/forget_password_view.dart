import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/register_text_field.dart';
import 'package:creen/features/forget_password/cubit/forget_cubit.dart';
import 'package:creen/features/forget_password/cubit/states/forget_state.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late ForgetPasswordCubit forgetPasswordCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit,ForgetPasswordStates>(listener: (BuildContext context, state) {  }, builder: (BuildContext context, ForgetPasswordStates state) {
        forgetPasswordCubit = ForgetPasswordCubit().get(context);
        return Scaffold(
          backgroundColor: liveBackground,
          body: SizedBox(
            width: size.width,
            child: Form(
              key: forgetPasswordCubit.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  RegisterTextField(
                    controller: forgetPasswordCubit.emailController,
                    type: TextInputType.emailAddress,
                    label:
                    // 'enter email',
                    'ادخل البريد الالكتروني',
                    validator: (txt){
                      if(txt!.isEmpty) {
                        return 'Empty Field';
                      }
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: ()=>forgetPasswordCubit.sendCode(context),
                    child: Container(
                      width: Sizes.screenWidth() * 0.7,
                      height: Sizes.screenHeight() * 0.07,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      alignment: Alignment.center,
                      color: Colors.green,
                      child: const Text(
                        // 'Send Code',
                        'طلب كود جديد',

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
