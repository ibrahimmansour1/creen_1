import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

import '../../core/utils/connectivity/connectivity_service.dart';
import '../../core/utils/routing/navigation_service.dart';
import '../../core/utils/widgets/text_button.dart';

class NoInternetConnection extends StatelessWidget {
  final bool fromSplash;
  const NoInternetConnection({
    this.fromSplash = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,


      body: Container(

        alignment: Alignment(0,0.5),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(kAppLogog),
              fit: BoxFit.cover,
            )
        ),

        child:            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: HelperFunctions.isArabic? TextDirection.rtl:TextDirection.ltr,
          children: [
          /*  CustomTextButton(
                title: 'reconnect',
                function: () {
                  ConnectivityService.instance
                      .checkIfConnected()
                      .then((value) {
                    NavigationService.goBack();

                    *//* if (fromSplash) {
                      NavigationService.pushReplacementAll(
                        isNamed: true,
                        page: RoutePaths.coreSplash,
                      );
                    } else {
                      NavigationService.goBack();
                    }*//*
                  });
                }),
        */    InkWell(onTap:(){
              ConnectivityService.instance
                  .checkIfConnected()
                  .then((value) {
                NavigationService.goBack();

                /* if (fromSplash) {
                      NavigationService.pushReplacementAll(
                        isNamed: true,
                        page: RoutePaths.coreSplash,
                      );
                    } else {
                      NavigationService.goBack();
                    }*/
              });
            },child: Image.asset('assets/images/ok.png',width: 50,)),
            Image.asset('assets/images/no_internet2.png',width: 100,),
          ],
        )
        /*Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
           *//* const SizedBox(
              height: 20,
            ),
            //    const CustomHeaderTitle(title: 'لا يوجد اتصال بالانترنت'),
            const SizedBox(
              height: 10,
            ),
            //     const CustomHeaderTitle(title: 'من فضلك افحص اتصالك بالانترنت'),
            const SizedBox(
              height: 10,
            ),*//*
          ],
        )*/,
      ),
    );
  }
}
