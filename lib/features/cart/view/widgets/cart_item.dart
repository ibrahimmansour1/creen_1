
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/elusive_icons.dart';

import '../../../../core/themes/themes.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/mirror_widget.dart';
import '../../model/my_cart_model.dart';

class CartItem extends StatelessWidget {
   CartItem({
    super.key,
    required this.tabStatus,
    required this.orderItem,
  });
bool tabStatus;
Order orderItem;
  @override
  Widget build(BuildContext context) {

      return InkWell(
      onTap: () {
        NavigationService.push(
          page: RoutePaths.cartDetails,
          isNamed: true,
          arguments: {"tabStatus":!tabStatus,"OrderItem":orderItem}
        );
      },
      child: Container(
        margin: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(
              10.r,
            )),
        padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: imageAsset(receive: tabStatus, recProfile: orderItem.receiver?.profile, senProfile: orderItem.sender?.profile),
                        child: imageChild(receive: tabStatus, recProfile: orderItem.receiver?.profile, senProfile: orderItem.sender?.profile),
                    ),
                    const BoxHelper(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(
                        '${tabStatus?orderItem.receiver?.name:orderItem.sender?.name}',
                        softWrap: true,
                        style: MainTheme.appBarTextStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${orderItem.order_status}',
                  style: MainTheme.appBarTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const BoxHelper(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 3.r,
                      backgroundColor: Colors.black,
                    ),
                    const BoxHelper(
                      width: 10,
                    ),
                    Text(
                      'كاش',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  'محلي',
                  style: MainTheme.appBarTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const BoxHelper(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '7000 \$',
                  style: MainTheme.appBarTextStyle.copyWith(
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Container(
                            height: 35.r,
                            width: 35.r,
                            margin: EdgeInsets.symmetric(horizontal: 15.r),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.share))),
                    InkWell(
                      child: Container(
                        height: 35.r,
                        width: 35.r,
                        margin: EdgeInsets.symmetric(horizontal: 10.r),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          shape: BoxShape.circle,
                        ),
                        child: const MirrorWidget(
                          child: Icon(Elusive.share),
                        ),
                      ),
                    ),
                    Text(
                      orderItem.time_ago!.substring(0,10),
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );

  }

}
Widget? imageChild({required bool receive ,required String ? recProfile, required String ? senProfile, }){
  if(receive){
    return(recProfile ?? "").isEmpty ||
        ((recProfile ?? "") == "null") ? Image.asset(
        "assets/images/profile.png") : null
    ;
  }
  else {
    return(senProfile ?? "").isEmpty ||
        ((senProfile ?? "") == "null") ? Image.asset(
        "assets/images/profile.png") : null
    ;
  }

}
imageAsset({required bool receive ,required String ? recProfile, required String ? senProfile,}){
  if(receive){
    return (recProfile??"").isNotEmpty && ((recProfile??"")!="null")?NetworkImage("${recProfile}"):null;
  }
  else{
    return (senProfile??"").isNotEmpty && ((senProfile??"")!="null")?NetworkImage("${senProfile}"):null;
  }
}
