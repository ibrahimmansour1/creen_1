
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/drawer/presentaion/pages/privacy.dart';
import 'package:creen/features/drawer/presentaion/pages/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

class TermsAcceptDialog extends StatelessWidget {
  const TermsAcceptDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isChecked = true;
    return Dialog(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Text(
              'agree_terms_policy'.translate,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.r),
            ),
          ),
          Row(
            children: [
              StatefulBuilder(builder: (context, setState) {
                return Checkbox(
                    activeColor: Colors.black,
                    value: isChecked,
                    onChanged: (v) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    });
              }),
              InkWell(
                onTap: () {
                  NavigationService.push(page: const PrivacyScreen());
                },
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Text('privacy_policy'.translate),
                ),
              ),
              SizedBox(
                width: 4.r,
              ),
              InkWell(
                onTap: () {
                  NavigationService.push(
                      page: const TermsAndConditionsScreen());
                },
                child: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Text('terms_of_use'.translate),
                ),
              ),
            ],
          ),
          const Divider(),
          InkWell(
            onTap: () async {
              if (!isChecked) {
                Fluttertoast.showToast(
                  msg: 'terms_agree_required'.translate,
                  backgroundColor: Colors.red,
                );
              } else {
                await GetStorage().write(
                  'accepted_rules',
                  'done',
                );
                NavigationService.goBack();
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'ok'.translate,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.r),
              ),
            ),
          ),
          SizedBox(
            height: 10.r,
          ),
        ],
      ),
    );
  }
}
