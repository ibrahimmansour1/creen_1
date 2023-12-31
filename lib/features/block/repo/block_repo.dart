
 import 'package:creen/features/block/model/block_model.dart';
import 'package:dio/dio.dart';

import '../../../core/themes/enums.dart';
import '../../../core/utils/network_utils.dart';

class BlockRepo{
 static Future<BlockModel?> blockUser({required  ReportType blockType,required int blockTypeId,bool block = false})async{
   Map<String,dynamic> body = {
     'model_type': blockType.name,
     'model_id': blockTypeId,

   };
    final util = NetworkUtil();
   var response;
    if(block)
      response = await util.post( 'block/delete',
        body: FormData.fromMap({'block_id':blockTypeId}),
      );

      else
    response = await util.post(
      'block',
      body: FormData.fromMap(body),
    );
    if (response == null) {
      return null;
    }
   var model = BlockModel.fromJson(response.data);
   return model;

  }
 }