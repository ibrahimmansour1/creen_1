import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/camera_btn.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/features/ads/view/widgets/ads_item.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:hooks_riverpod/hooks_riverpod.dart';

//final valueProvider1 = StateProvider((ref) => '');
// ignore: must_be_immutable
class PhotoAdScreen extends ConsumerWidget {
  PhotoAdScreen({Key? key}) : super(key: key);
  String? value;

  final items = [
    'ads_advertise'.translate,
    'good_advertisment'.translate,
    'service_ads'.translate,
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // String value1 = ref.watch(valueProvider1);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'image_ad_add',
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
              Column(
                children: [
                  SizedBox(
                    height: Sizes.screenWidth() * 0.15,
                  ),
                  AdsItem(
                    text: '',
                    isMessage: true,
                    content: 'department',
                    widget: DropdownButtonHideUnderline(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButton<String?>(
                          value: value,
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (String? value) {},
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          hint:  Text('job_ads'.translate),
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: CameraButton(
                      width: Sizes.screenWidth() * 0.9,
                      title: 'upload_photo'.translate,
                      function: () {},
                      radius: 25,
                      isImage: true,
                    ),
                  ),
                  AdsItem(
                    text: '',
                    isMessage: false,
                    onChanged: (v) {},
                    content: 'whats',
                  ),
                  AdsItem(
                    text: '',
                    isMessage: false,
                    onChanged: (v) {},
                    content: 'link',
                  ),
                  SizedBox(
                    height: Sizes.screenHeight() * 0.06,
                  ),
                  CustomTextButton(
                    width: Sizes.screenWidth() * 0.9,
                    title: 'add',
                    function: () {},
                    radius: 25,
                  ),
                  SizedBox(
                    height: Sizes.screenHeight() * 0.06,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String?> buildMenuItem(String? item) => DropdownMenuItem(
        value: item,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            // decoration:  const BoxDecoration(
            //             border: Border(
            //                 bottom: BorderSide(color: MainStyle.navigationColor)),
            //           ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                item == 'ads_advertise'.translate
                    ? const Icon(Icons.work)
                    : item == 'good_advertisment'.translate
                        ? const Icon(Icons.shopping_cart)
                        : const Icon(Icons.account_balance_wallet),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  item!,
                ),
              ],
            ),
          ),
        ),
      );
}
