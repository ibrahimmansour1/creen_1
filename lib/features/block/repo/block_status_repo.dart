

import 'package:creen/features/block/model/bloc_status_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/network_utils.dart';

class BlockStatusRepo {

  static Future<BlocStatusModel?> blockStatus({required int? id})async{
    Map<String,dynamic> body = {
      'user_id': id,


    };
    final util = NetworkUtil();
    var response= await util.post(
    'block/status',
    body: FormData.fromMap(body),
    );
    if (response == null) {
    return null;
    }
    var model = BlocStatusModel.fromJson(response.data);
    return model;


  }

}