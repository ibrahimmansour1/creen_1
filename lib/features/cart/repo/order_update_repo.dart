import 'package:dio/dio.dart';
import '../../../core/utils/network_utils.dart';
import '../model/order_status_model.dart';

class OrderUpdateRepo {
  static Future<OrderStatusModel?> orderUpdateRepo({required int id,required String status})async{
   Map<String, Object> body ={
     'id':id,
     'status':status,
   };
   print("order status update body ====> $body");
    final util = NetworkUtil();

    var response = await util.post(
      'orders/status',
      body: FormData.fromMap(
        body,
      ),
    );
    if (response == null) {
      return null;
    }

    var model = OrderStatusModel.fromJson(response.data);

    return model;
  }
}