import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/themes.dart';
import '../routing/navigation_service.dart';
import 'box_helper.dart';

class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    NavigationService.goBack();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Image.asset(
              'assets/images/coming-soon.jpg',
              height: 100.r,
              width: 100.r,
            ),
            const BoxHelper(
              height: 15,
            ),
            Text(
              'coming_soon_dialog'.translate,
              style: MainTheme.authTextStyle.copyWith(fontSize: 18.r),
            ),
            const BoxHelper(
              height: 15,
            ),
            RegisterButton(
              radius: 10,
              title: 'ok',
              onPressed: () {
                NavigationService.goBack();
              },
            ),
          ],
        ),
      ),
    );
  }
}
