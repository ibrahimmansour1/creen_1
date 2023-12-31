import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShareItem extends ConsumerWidget {
  final Widget? icon;
  final String? text;
  final void Function()? onTap;
  const ShareItem(this.icon, this.text, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizes.screenWidth() * 0.45,
        height: Sizes.screenHeight() * 0.22,
        //padding: const EdgeInsets.all(25.0),
        decoration: const BoxDecoration(
            color: MainStyle.shareColor,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            border: Border(
                bottom: BorderSide(color: Color(0xffE7E7E7)),
                left: BorderSide(color: Color(0xffE7E7E7)),
                right: BorderSide(color: Color(0xffE7E7E7)),
                top: BorderSide(color: Color(0xffE7E7E7)))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(
              height: 10,
            ),
            Text(
              text!.translate,
              style: MainTheme.authTextStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: MainStyle.primaryColor,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
