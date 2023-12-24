import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/register_button.dart';
import 'package:creen/features/ads/view/widgets/ads_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BmiSettingsScreen extends StatefulWidget {
  const BmiSettingsScreen({super.key});

  @override
  State<BmiSettingsScreen> createState() => _BmiSettingsScreenState();
}

class _BmiSettingsScreenState extends State<BmiSettingsScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController tallController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController kindController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('settings'.translate),
        titleTextStyle: const TextStyle(color: Colors.white),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
          onPressed: () {
            NavigationService.goBack();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                 AdsItem(
                  text: 'tall'.translate,
                  isMessage: false,
                  keyboardType: TextInputType.phone,
                  validator:(str){
                    if(str!.isEmpty) {
                      return "empty".translate;
                    }
                    return null;
                },
                   controller: tallController,

                ),
                 AdsItem(
                  text: 'weight'.translate,
                  isMessage: false,
                  keyboardType: TextInputType.phone,
                     validator:(str){
                       if(str!.isEmpty) {
                         return "empty".translate;
                       }
                       return null;
                     },
                   controller: weightController,
                ),
                 AdsItem(
                  text: 'age'.translate,
                  isMessage: false,
                  keyboardType: TextInputType.phone,
                     validator:(str){
                       if(str!.isEmpty) {
                         return "empty".translate;
                       }
                       return null;
                     },
                   controller: ageController,
                ),
                 AdsItem(
                  text: 'type'.translate,
                  isMessage: false,
                  keyboardType: TextInputType.name,
                     validator:(str){
                       if(str!.isEmpty) {
                         return "empty".translate;
                       }
                       return null;
                     },
                   controller: kindController,
                ),
                RegisterButton(
                  title: 'save'.translate,
                  color: Colors.green,
                  radius: 10,
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      Fluttertoast.showToast(msg: 'data saved'.translate);

                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
