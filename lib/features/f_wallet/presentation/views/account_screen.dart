
import 'package:creen/features/f_wallet/presentation/views/widgets/account-card-info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/default_appbar.dart';


class AccountScreen extends StatelessWidget {
   const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DefaultAppBar(txt:"حسابي"),
               SizedBox(
                height: 20.h,
              ),
             const AccountCardInfo(),
              SizedBox(
                height: 15.h,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
