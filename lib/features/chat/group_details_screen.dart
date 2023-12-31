import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupDetailScreen extends StatefulWidget {
  const GroupDetailScreen({super.key});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Image.asset(
                  'assets/images/product.jpg',
                  height: 200.r,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(CupertinoIcons.multiply),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'group_name'.translate,
                    style: MainTheme.appBarTextStyle.copyWith(
                      fontSize: 20.r,
                    ),
                  ),
                  const BoxHelper(
                    height: 10,
                  ),
                  Text(
                    '${'created_by'.translate} د.  محمد حمد العمري ${'in'.translate} 13/05/2023',
                    style: MainTheme.appBarTextStyle
                        .copyWith(fontSize: 15.r, color: Colors.white60),
                  ),
                  const BoxHelper(
                    height: 20,
                  ),
                  Text(
                    '${'members'.translate} :',
                    style: MainTheme.appBarTextStyle.copyWith(
                      fontSize: 20.r,
                    ),
                  ),
                  const BoxHelper(
                    height: 15,
                  ),
                  ...List.generate(
                    10,
                    (index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 8.r),
                      leading: CircleAvatar(
                        radius: 20.r,
                        backgroundImage: const AssetImage(
                          'assets/images/profile2.png',
                        ),
                      ),
                      title: Text(
                        'member_name'.translate,
                        style: MainTheme.appBarTextStyle.copyWith(
                          fontSize: 14.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
