import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/core/validations/auth_validator.dart';
import 'package:creen/features/ads/view/widgets/ads_item.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewModel/contactUs/contact_us_cubit.dart';

//final valueProvider1 = StateProvider((ref) => '');
class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late ContactUsCubit contactUsCubit;

  @override
  void initState() {
    contactUsCubit = context.read<ContactUsCubit>();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // String value1 = ref.watch(valueProvider1);

    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'contact_us',
          )),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.black45],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                tileMode: TileMode.clamp)),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: ListView(
            children: [
              Form(
                key: contactUsCubit.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: Sizes.screenWidth() * 0.15,
                    ),
                    AdsItem(
                      text: '',
                      isMessage: false,
                      onChanged: (v) {},
                      hintText: 'name',
                      controller: contactUsCubit.nameController,
                      validator: AuthValidator.nameValidator,
                    ),
                    AdsItem(
                      text: '',
                      isMessage: false,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (v) {},
                      hintText: 'email',
                      controller: contactUsCubit.emailController,
                      validator: contactUsCubit.emailValidator,
                    ),
                    AdsItem(
                      text: '',
                      isMessage: false,
                      onChanged: (v) {},
                      hintText: 'phone_number',
                      keyboardType: TextInputType.phone,
                      controller: contactUsCubit.mobileController,
                      validator: contactUsCubit.phoneValidator,
                    ),
                    AdsItem(
                      text: '',
                      isMessage: true,
                      onChanged: (v) {},
                      hintText: 'message',
                      controller: contactUsCubit.messageController,
                      validator: contactUsCubit.messageValidator,
                    ),
                    SizedBox(
                      height: Sizes.screenHeight() * 0.06,
                    ),
                    BlocBuilder<ContactUsCubit, ContactUsState>(
                      builder: (context, state) {
                        if (state is ContactUsLoading) {
                          return const LoaderWidget();
                        }
                        return CustomTextButton(
                          width: Sizes.screenWidth() * 0.9,
                          title: 'send',
                          function: () => contactUsCubit.contactUs(),
                          radius: 25,
                          send: true,
                        );
                      },
                    ),
                    SizedBox(
                      height: Sizes.screenHeight() * 0.06,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
