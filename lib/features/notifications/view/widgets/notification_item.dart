import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/features/notifications/view/pages/notification.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/functions/helper_functions.dart';

class NotificationItem extends ConsumerWidget {
  final String? name, text, image;
  final bool read;
final bool? erase;
final void Function()? onTap;
  const NotificationItem(this.name, this.text, this.image, this.onTap, this.erase,
      {Key? key,this.read = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("${HelperFunctions.currentLanguage}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: read?Colors.white:Colors.grey.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: HelperFunctions.currentLanguage=='en'?TextDirection.ltr:TextDirection.rtl,
                children: [
                  //const SizedBox(width: 15,),
                  Container(
                    height: Sizes.screenWidth() * 0.08,
                    width: Sizes.screenWidth() * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(image!), fit: BoxFit.cover,
                          // colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.dst)
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: Sizes.screenWidth() * 0.6,
                    child: Text(
                      name!,
                      maxLines: 1,
                      overflow: TextOverflow.clip,

                      style: MainTheme.authTextStyle.copyWith(fontSize: 15,color: Colors.white),
                    ),
                  ),


/*
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     textDirection: HelperFunctions.currentLanguage=='en'?TextDirection.ltr:TextDirection.rtl,
                      children: [
                        Text(
                          name!,

                          style: MainTheme.authTextStyle.copyWith(fontSize: 15,color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
*/
/*
                        Row(
                          children: [
                            Text(text!,style: const TextStyle(color: Colors.white),),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'here'.translate,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
*//*

                      ],
                    ),
                  ),
*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: erase == null ?Image.asset('assets/images/delete.png'):Icon(erase!?Icons.check_box_outlined:Icons.check_box_outline_blank_outlined,color: Colors.white,),
              )

            ],
          ),
        ),
      ),
    );
  }
}
