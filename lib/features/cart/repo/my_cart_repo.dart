import '../../../core/utils/network_utils.dart';
import '../model/my_cart_model.dart';

class MyCartRepo {
  static Future<CartModel?> myCart() async {
    final util = NetworkUtil();

    var response = await util.get(
      'carts',
    );
    if (response == null) {
      return null;
    }

    var model = CartModel.fromJson(response.data);

    return model;
  }
}

class MyOrderRepo{


  static Future<dynamic> myOrder({bool customerOrder = true}) async {
    final util = NetworkUtil();

    var response = await util.get(customerOrder?'orders/send':'orders'
      ,
    );
    if (response == null) {
      return null;
    }
return response;


  }

}
