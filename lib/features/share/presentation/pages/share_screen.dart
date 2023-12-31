import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/share/presentation/widgets/share_item.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShareScreen extends ConsumerWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text('share'.translate,
              style: MainTheme.appBarTextStyle.copyWith(
                color: MainStyle.primaryColor,
              )),
          backgroundColor: Colors.white,
          leading: InkWell(
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onTap: () => NavigationService.goBack(),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: Sizes.screenWidth() * 0.18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShareItem(
                    const ImageIcon(AssetImage('assets/images/email.png')),
                    'email'.translate,
                    () {}),
                const SizedBox(
                  width: 10,
                ),
                ShareItem(
                    const ImageIcon(AssetImage('assets/images/whatsapp.png')),
                    'whats',
                    () {}),
              ],
            ),
            SizedBox(
              height: Sizes.screenWidth() * 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShareItem(const ImageIcon(AssetImage('assets/images/chat.png')),
                    'convert_to_converation', () {}),
                const SizedBox(
                  width: 10,
                ),
                ShareItem(
                    const ImageIcon(AssetImage('assets/images/twitter.png')),
                    'twitter',
                    () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
