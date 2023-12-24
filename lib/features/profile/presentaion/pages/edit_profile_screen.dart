import 'dart:developer';

import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/core/utils/widgets/register_button.dart';
import 'package:creen/core/utils/widgets/register_text_field.dart';
import 'package:creen/core/validations/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../../core/utils/widgets/radio_tile.dart';
import '../../viewModel/profile/profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileCubit profileCubit;
  final formKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    profileCubit = context.read<ProfileCubit>()..initCtrls();
    // profileCubit.blockStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: profileCubit.removeCtrls,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'profile_edit',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    const BoxHelper(
                      height: 10,
                    ),
                    RegisterTextField(
                      label: 'name',
                      controller: profileCubit.nameController,
                      validator: AuthValidator.nameValidator,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    RegisterTextField(
                      label: 'email',
                      controller: profileCubit.emailController,
                      validator: AuthValidator.emailValidator,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    RegisterTextField(
                      label: 'phone_number',
                      controller: profileCubit.phoneController,
                      validator: AuthValidator.phoneValidator,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    RegisterTextField(
                      label: 'address',
                      controller: profileCubit.addressController,
                      validator: AuthValidator.addressValidator,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 150.r,
                      ),
                      child: RegisterTextField(
                        label: 'about_me',
                        controller: profileCubit.aboutController,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      RadioTile<String?>(
                        txtColor: Colors.white,
                        fillColor: Colors.white,
                        title: 'male',
                        value: 'male',
                        groupValue: profileCubit.gender,
                        onChanged: profileCubit.onGenderChanged,
                      ),
                      RadioTile<String?>(
                        txtColor: Colors.white,
                        fillColor: Colors.white,
                        title: 'female',
                        value: 'female',
                        groupValue: profileCubit.gender,
                        onChanged: profileCubit.onGenderChanged,
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state ==
                      const UpdateProfileLoading(mode: UpdatingMode.userData)) {
                    return const LoaderWidget(
                      color: Colors.white,
                    );
                  }
                  return RegisterButton(
                    title: 'save',
                    color: Colors.white,
                    radius: 10.r,
                    onPressed: () {
                      var validate = formKey.currentState?.validate() ?? false;
                      if (!validate) {
                        return;
                      }
                      profileCubit.updateProfile(context,
                          updatingMode: UpdatingMode.userData);
                    },
                  );
                },
              ),
              const BoxHelper(
                height: 40,
              ),
              Form(
                key: passwordFormKey,
                child: Column(
                  children: [
                    RegisterTextField(
                      label: 'password',
                      controller: profileCubit.passwordController,
                      validator: AuthValidator.phoneValidator,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    RegisterTextField(
                      label: 'confirm_password',
                      controller: profileCubit.passwordConfirmationController,
                      validator: (v) =>
                          AuthValidator.passwordConfirmationValidator(
                        v,
                        passwordController: profileCubit.passwordController!,
                      ),
                    ),
                  ],
                ),
              ),
              const BoxHelper(
                height: 10,
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state ==
                      const UpdateProfileLoading(mode: UpdatingMode.password)) {
                    return const LoaderWidget(
                      color: Colors.white,
                    );
                  }
                  return RegisterButton(
                    title: 'save',
                    color: Colors.white,
                    radius: 10.r,
                    onPressed: () {
                      var validate =
                          passwordFormKey.currentState?.validate() ?? false;
                      log('$validate', name: 'key_validate');
                      if (!validate) {
                        return;
                      }
                      profileCubit.updateProfile(
                        context,
                        updatingMode: UpdatingMode.password,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
