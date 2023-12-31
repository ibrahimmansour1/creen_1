import 'dart:developer';

import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/dropdown_widget.dart';
import 'package:creen/core/utils/widgets/register_text_field.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/core/validations/auth_validator.dart';
import 'package:creen/features/Auth/viewModel/register/register_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/loader_widget.dart';
import '../../../../core/utils/widgets/radio_tile.dart';
import '../../../addressData/viewModel/addressData/address_data_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register_page';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterCubit registerCubit;
  late AddressDataCubit addressDataCubit;
  int? phoneCode;

  @override
  void initState() {
    registerCubit = context.read<RegisterCubit>();
    addressDataCubit = context.read<AddressDataCubit>()..getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    // double aspectRatio = MediaQuery.sizeOf(context).aspectRatio ;
    // double height = MediaQuery.sizeOf(context).height;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/black background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  // top: (Sizes.screenHeight()*Sizes.screenWidth()>=(585.0*768))?Sizes.screenHeight() * 0.38:Sizes.screenHeight() * 0.25,

                  top: Sizes.screenHeight() * 0.25,
                ),
                child: Center(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: SizedBox(
                      height: Sizes.screenHeight() * 0.65,
                      width: Sizes.screenWidth() * 0.85,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Sizes.screenHeight() * 0.02,
                            ),
                            Text(
                              'sign_up'.translate,
                              style: MainTheme.authTextStyle,
                            ),
                            SizedBox(
                              height: Sizes.screenHeight() * 0.04,
                            ),
                            BlocBuilder<AddressDataCubit, AddressDataState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    state is CountriesLoading
                                        ? const LoaderWidget()
                                        : DropdownTileItem(
                                            values: addressDataCubit.countries
                                                .map((e) {
                                              return e.name ?? '';
                                            }).toList(),
                                            title: 'country',
                                            onChanged: (v) {
                                              if (v == null) {
                                                return;
                                              }
                                              var countryId = addressDataCubit
                                                  .countries[v].id;
                                              setState(() {
                                                phoneCode = addressDataCubit
                                                    .countries[v].phoneCode;
                                              });
                                              log('e code ${addressDataCubit.countries[v].phoneCode}');

                                              addressDataCubit
                                                  .getCitiesByCountryId(
                                                countryId: countryId,
                                              );
                                            },
                                            validator:
                                                AuthValidator.countryValidator,
                                          ),
                                    Visibility(
                                      visible:
                                          addressDataCubit.cities.isNotEmpty,
                                      child: DropdownTileItem(
                                        validator: AuthValidator.cityValidator,
                                        values: addressDataCubit.cities
                                            .map((e) => e.name ?? '')
                                            .toList(),
                                        title: 'city',
                                        onChanged: (v) {
                                          if (v == null) {
                                            return;
                                          }
                                          registerCubit.cityId =
                                              addressDataCubit.cities[v].id;
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            FieldTileItem(
                              title: 'phone_number',
                              labelText: 'enter_phone',
                              validator: AuthValidator.phoneValidator,
                              leadingIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              controller: registerCubit.phoneController,
                              prefixCode: '${phoneCode==2?20:phoneCode}+',
                            ),
                            BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    RadioTile(
                                      title: 'male',
                                      value: 'male',
                                      groupValue: registerCubit.gender,
                                      onChanged: registerCubit.onChanged,
                                    ),
                                    RadioTile(
                                      title: 'female',
                                      value: 'female',
                                      groupValue: registerCubit.gender,
                                      onChanged: registerCubit.onChanged,
                                    ),
/*
                                    RadioTile(
                                      title: 'notprefer',
                                      value: 'femal',
                                      groupValue: registerCubit.gender,
                                      onChanged: registerCubit.onChanged,
                                    ),
*/
                                  ],
                                );
                              },
                            ),
                            Form(
                              key: registerCubit.formKey,
                              child: Column(
                                children: [
                                  FieldTileItem(
                                    title: 'name',
                                    validator: AuthValidator.nameValidator,
                                    leadingIcon: Icons.person_outline,
                                    labelText: 'enter_name',
                                    controller: registerCubit.nameController,
                                  ),
                                  FieldTileItem(
                                    title: 'age',
                                    labelText: 'enter_age',
                                    // validator: AuthValidator.ageValidator,
                                    leadingIcon: Icons.person_outline,
                                    keyboardType: TextInputType.phone,
                                    controller: registerCubit.ageController,
                                  ),
                                  FieldTileItem(
                                    title: 'address',
                                    labelText: 'enter_address',
                                    // validator: AuthValidator.addressValidator,
                                    leadingIcon: Icons.location_city_outlined,
                                    controller: registerCubit.addressController,
                                  ),
                                  FieldTileItem(
                                    title: 'email',
                                    labelText: 'enter_email',
                                    validator: AuthValidator.emailValidator,
                                    leadingIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: registerCubit.emailController,
                                  ),
                                  FieldTileItem(
                                    title: 'password',
                                    labelText: 'enter_password',
                                    validator: AuthValidator.passwordValidator,
                                    leadingIcon: Icons.password_outlined,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller:
                                        registerCubit.passwordController,
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: Sizes.screenHeight() * 0.03,
                                  ),
                                  BlocBuilder<RegisterCubit, RegisterState>(
                                    builder: (context, state) {
                                      if (state is RegisterLoading) {
                                        return const LoaderWidget();
                                      }
                                      return CustomTextButton(
                                        width: Sizes.screenWidth() * 0.7,
                                        title: 'sign_up',
                                        function: () =>
                                            registerCubit.register(),
                                        radius: 25,
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        'have_acc'.translate,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          NavigationService.goBack();
                                        },
                                        child: Text(
                                          'sign_in'.translate,
                                          style: const TextStyle(
                                              color: MainStyle.primaryColor,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
            width: size.width * 0.75 * size.aspectRatio,
            child: Image.asset(
              "assets/images/logoo.png",
            )),
      ],
    );
  }
}

class FieldTileItem extends StatelessWidget {
  const FieldTileItem({
    Key? key,
    this.controller,
    this.validator,
    required this.title,
    this.leadingIcon,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType, this.prefixCode,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String title, labelText;
  final String? prefixCode;
  final IconData? leadingIcon;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: Sizes.screenHeight() * 0.07,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: MainStyle.mainGray)),
      ),
      child: RegisterTextField(
        icon: leadingIcon,
        type: keyboardType,
        label: labelText,
        controller: controller,
        validator: validator,
        obsecureText: obscureText,
        register: true,
        prefixCode: prefixCode,
      ),
    );
  }
}

class DropdownTileItem extends StatelessWidget {
  const DropdownTileItem({
    Key? key,
    required this.title,
    required this.values,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);
  final String title;
  final List<String> values;
  final void Function(int?) onChanged;
  final String? Function(int?) validator;

  @override
  Widget build(BuildContext context) {
    return         Container(
      // height: Sizes.screenHeight() * 0.07,
      margin: const EdgeInsets.symmetric(horizontal: 20),

      child: DropDownWidget(
        onChanged: onChanged,
        labelText: title,
        values: values,
        validator: validator,
      ),
    )
    ;
  }
}
