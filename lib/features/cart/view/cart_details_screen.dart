import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/custom_image.dart';
import 'package:creen/core/utils/widgets/register_button.dart';
import 'package:creen/features/cart/repo/order_update_repo.dart';
import 'package:creen/features/cart/view/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/themes/enums.dart';

class CartDetailsScreen extends StatefulWidget {
  const CartDetailsScreen({super.key, required this.customer});

  final Map<String, dynamic> customer;

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> {
  List<IconData> iconsList = [
    Icons.check_circle_outline,
    Icons.pending,
    Icons.delivery_dining,
    Icons.cancel,
  ];

  @override
  Widget build(BuildContext context) {
    print("customer ${widget.customer}");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 15.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.customer["tabStatus"]) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.r),
                    child: Text(
                      '${'seller'.translate} :',
                      style: MainTheme.authTextStyle.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (widget.customer["tabStatus"])
                            CircleAvatar(
                                radius: 20.r,
                                backgroundImage: imageAsset(
                                    receive: !widget.customer["tabStatus"],
                                    recProfile: widget.customer["OrderItem"]
                                        .receiver?.profile,
                                    senProfile: widget
                                        .customer["OrderItem"].sender?.profile),
                                child: imageChild(
                                    receive: !widget.customer["tabStatus"],
                                    recProfile: widget.customer["OrderItem"]
                                        .receiver?.profile,
                                    senProfile: widget
                                        .customer["OrderItem"].sender?.profile))
                          else
                            CircleAvatar(
                                radius: 20.r,
                                backgroundImage: NetworkImage(
                                    "${HelperFunctions.currentUser!.profile}"),
                                child: HelperFunctions.currentUser!.profile ==
                                        null
                                    ? Image.asset("assets/images/profile.png")
                                    : null),
                          const BoxHelper(
                            width: 10,
                          ),
                          Text(
                            '${widget.customer["tabStatus"] ? widget.customer["OrderItem"].receiver?.name : HelperFunctions.currentUser!.name}',
                            style: MainTheme.appBarTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      PopupMenuButton(
                        onSelected: (value) async{
                          setState(() {
                            widget.customer["OrderItem"].order_status = value;
                          });

                          await OrderUpdateRepo.orderUpdateRepo(id: widget.customer["OrderItem"].order_id, status: widget.customer["OrderItem"].order_status).then((value) => print("order update response ==> ${value?.status}")).catchError((e)=>print("order update error ==> $e"));
                        },
                        position: PopupMenuPosition.under,
                        itemBuilder: (_) {
                          List<PopupMenuEntry> widget = List.generate(OrderStatus.values.length, (index) => HelperFunctions.buildPopupMenu(
                            icons: iconsList[index],
                            title: OrderStatus.values[index].name,
                            value: OrderStatus.values[index].name,

                          ),);

                          return widget;
                        },
                        child:                       Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          padding: EdgeInsets.all(4.r),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20.r,
                              ),
                              Text(
                                '${widget.customer["OrderItem"].order_status}',
                                style: MainTheme.appBarTextStyle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                        ,
                      ),

                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.r),
                  child: Text(
                    '${'customer'.translate} :',
                    style: MainTheme.authTextStyle.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 20.r,
                        backgroundImage: widget.customer["tabStatus"]
                            ? ((HelperFunctions.currentUser?.profile == null)
                                ? null
                                : NetworkImage(
                                    HelperFunctions.currentUser!.profile))
                            : imageAsset(
                                receive: !widget.customer["tabStatus"],
                                recProfile: widget
                                    .customer["OrderItem"].receiver?.profile,
                                senProfile: widget
                                    .customer["OrderItem"].sender?.profile),
                        child: (widget.customer["tabStatus"] &&
                                HelperFunctions.currentUser?.profile == null)
                            ? imageChild(
                                receive: !widget.customer["tabStatus"],
                                recProfile: widget
                                    .customer["OrderItem"].receiver?.profile,
                                senProfile: widget
                                    .customer["OrderItem"].sender?.profile)
                            : null),
                    const BoxHelper(
                      width: 10,
                    ),
                    Text(
                      '${widget.customer["tabStatus"] ? HelperFunctions.currentUser!.name : widget.customer["OrderItem"].receiver?.name}',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                const BoxHelper(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'country'.translate} ـــــــ',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${'phone_number'.translate} ${widget.customer["tabStatus"] ? HelperFunctions.currentUser!.mobile : widget.customer["OrderItem"].receiver?.mobile}",
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const BoxHelper(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'city'.translate} ${widget.customer["tabStatus"] ? HelperFunctions.currentUser!.name : null}',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${'distract'.translate} ـــــــ',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const BoxHelper(
                  height: 15,
                ),
             /*   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'عنوان آخر ــــــــــــــــــ',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const BoxHelper(
                  height: 15,
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' ${'email'.translate}  ${widget.customer["tabStatus"] ? HelperFunctions.currentUser!.email : widget.customer["OrderItem"].receiver?.email}',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
/*
                    Text(
                      'رقم آخر ـــــــ',
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
*/
                  ],
                ),
                const BoxHelper(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                ),
                const BoxHelper(
                  height: 10,
                ),
                if (widget.customer["tabStatus"]) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.r),
                    child: Text(
                      '${'seller'.translate} :',
                      style: MainTheme.authTextStyle.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 20.r,
                              backgroundImage: imageAsset(
                                  receive: !widget.customer["tabStatus"],
                                  recProfile: widget
                                      .customer["OrderItem"].receiver?.profile,
                                  senProfile: widget
                                      .customer["OrderItem"].sender?.profile),
                              child: imageChild(
                                  receive: !widget.customer["tabStatus"],
                                  recProfile: widget
                                      .customer["OrderItem"].receiver?.profile,
                                  senProfile: widget
                                      .customer["OrderItem"].sender?.profile)),
                          const BoxHelper(
                            width: 10,
                          ),
                          Text(
                            '${widget.customer["OrderItem"].sender?.name}',
                            style: MainTheme.appBarTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      if (widget.customer["tabStatus"])
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          padding: EdgeInsets.all(4.r),
                          child: Text(
                            '${widget.customer["OrderItem"].order_status}',
                            style: MainTheme.appBarTextStyle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
                ...List.generate(
                  5,
                  (index) => const InvoiceProductItem(),
                ),
                Text(
                  'add_tax'.translate,
                  style: MainTheme.authTextStyle.copyWith(
                    fontSize: 15.r,
                  ),
                ),
                const BoxHelper(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Text(
                        'payment'.translate,
                        style: MainTheme.authTextStyle.copyWith(
                          fontSize: 15.r,
                        ),
                      ),
                    ),
                    Text(
                      '${'total_price'.translate} \n19',
                      textAlign: TextAlign.center,
                      style: MainTheme.authTextStyle.copyWith(
                        fontSize: 15.r,
                      ),
                    ),
                  ],

                  //اكمال الطلب عند البائع و عند العميل
                  //عند الضغط بالنسبه للدفع
                  //لو العميل دفع يظهر الطلب مكتمل و يوجهه للصفحه الرئيسيه
                  //
                ),
                const BoxHelper(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // QrImage(
                    //   data: "1234567890",
                    //   version: QrVersions.auto,
                    //   size: 120.r,
                    // ),
                    Column(
                      children: [
                        Text(
                          'code'.translate,
                          style: MainTheme.authTextStyle.copyWith(
                            fontSize: 15.r,
                          ),
                        ),
                        const BoxHelper(
                          height: 15,
                        ),
                        Text(
                          'tax_number'.translate,
                          style: MainTheme.authTextStyle.copyWith(
                            fontSize: 15.r,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/DHL.png',
                      height: 100.r,
                      width: 100.r,
                    )
                  ],
                ),
                RegisterButton(
                  title: 'complete_order',
                  onPressed: () {},
                  radius: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InvoiceProductItem extends StatelessWidget {
  const InvoiceProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.r),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomImage(
                networkImage: '',
                horizontalPadding: 5,
                responsiveHeight: 100,
                responsiveWidth: 100,
                responsiveRadius: 5,
              ),
              const BoxHelper(
                width: 5,
              ),
              BoxHelper(
                width: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BoxHelper(
                      height: 15,
                    ),
                    Text(
                      'ساعة رياضية',
                      style: MainTheme.authTextStyle.copyWith(
                        fontSize: 16.r,
                      ),
                    ),
                    const BoxHelper(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'number'.translate} : 4',
                          style: MainTheme.authTextStyle.copyWith(
                            fontSize: 16.r,
                          ),
                        ),
                        Text(
                          '${'value'.translate} : 600 \$',
                          style: MainTheme.authTextStyle.copyWith(
                            fontSize: 16.r,
                          ),
                        ),
                      ],
                    ),
                    const BoxHelper(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'size'.translate} : xl',
                          style: MainTheme.authTextStyle.copyWith(
                            fontSize: 16.r,
                          ),
                        ),
                        Text(
                          '${"color".translate} : أحمر',
                          style: MainTheme.authTextStyle.copyWith(
                            fontSize: 16.r,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const BoxHelper(
            height: 5,
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
