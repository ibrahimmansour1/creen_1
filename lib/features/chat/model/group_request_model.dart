import 'dart:io';

import 'package:dio/dio.dart';

class GroupRequestModel {
  const GroupRequestModel({
    required this.groupName,
    required this.image,
  });

  final File? image;
  final String groupName;

  Future<Map<String, dynamic>> toJson() async => {
        'teamFile':
            image == null ? null : await MultipartFile.fromFile(image!.path),
        'teamname': groupName,
      };
}
