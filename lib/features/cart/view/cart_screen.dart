
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/cart/repo/my_cart_repo.dart';
import 'package:creen/features/cart/view/widgets/cart_item.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/responsive/sizes.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../model/my_cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  // late CartCubit cartCubit;
  List<Order> myOrders = [];
  late TabController controller;
  int tabIndex = 0;

  @override
  void initState() {
    // cartCubit = context.read<CartCubit>()..getMyCart();
    getMyorders();
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'cart',
          ),
        ),
        body: myOrders.isEmpty?const Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TabBar(
                indicatorColor: Colors.green,
                labelColor: Colors.black,
                controller: controller,
                tabs: [
                  Text(
                    'my_orders'.translate,
                  ),
                  Text(
                    'customers_orders'.translate,
                  ),
                ],
                onTap: (count) async {
                  setState(() {
                    tabIndex = count;
                  });
                  await getMyorders(receive: tabIndex == 1);

                },
              ),
              if((myOrders[0].sender ==null && tabIndex==1)||(myOrders[0].receiver ==null && tabIndex==0))
              ...List.generate(
                myOrders.length,
                (index) {
                  // print("myOrders.length ${myOrders.length}");
                  var order = myOrders[index];
                  // print("bbbbbbbbbbbbbb ${order.receiver?.profile}");
                  return CartItem(
                    tabStatus: (tabIndex) == 1,
                    orderItem: order,
                  );
                },
              )
              else
               Padding(
                 padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),
                 child: const CircularProgressIndicator(),
               ) ,
            ],
          ),
        ));
  }

  DataCell buildDataCell({
    required String title,
  }) {
    return DataCell(
      Text(title),
    );
  }

  DataColumn buildDataColumn({
    required String title,
  }) {
    return DataColumn(
      label: Text(
        title.translate,
      ),
    );
  }

  Future<void> getMyorders({bool receive = false}) async {
    var response = await MyOrderRepo.myOrder(customerOrder: receive);
    myOrders = [];
    // log("Orders response: ...${response}");
    var responseData = response.data["data"]["orders"]["data"];
// print("responseDataid ${responseData[0]["user_receive"]}");
    if (receive) {
      for (int index = 0; index < responseData.length; index++) {
        myOrders.add(Order(
            order_id: responseData[index]["id"],
            receiver: Human(
                id: responseData[index]["user_receive"]["id"],
                name: responseData[index]["user_receive"]["name"],
                email: responseData[index]["user_receive"]["email"],
                profile: responseData[index]["user_receive"]["profile"],
                mobile: responseData[index]["user_receive"]["mobile"],
                country: responseData[index]["user_receive"]["country_id"],
                city: responseData[index]["user_receive"]["city_id"]),
            order_status: responseData[index]["status"],
            payment_method: "${responseData[index]["id"]}",
            time_ago: responseData[index]["created_at"],
            price: "${responseData[index]["id"]}"));
      }
    } else {
      for (int index = 0; index < responseData.length; index++) {
        myOrders.add(Order(
            order_id: responseData[index]["id"],
            sender: Human(
                id: responseData[index]["user_send"]["id"],
                name: responseData[index]["user_send"]["name"],
                email: responseData[index]["user_send"]["email"],
                profile: responseData[index]["user_send"]["profile"],
                mobile: responseData[index]["user_send"]["mobile"],
                country: responseData[index]["user_send"]["country_id"],
                city: responseData[index]["user_send"]["city_id"]),
            order_status: responseData[index]["status"],
            payment_method: "${responseData[index]["id"]}",
            time_ago: responseData[index]["created_at"],
            price: "${responseData[index]["id"]}"));
      }
    }
    setState(() {});
    // print("myOrders.length ${myOrders.length}");
    // print("ggghgfgvfg ${myOrders[0].sender?.profile}");

// response["data"]
  }
}
