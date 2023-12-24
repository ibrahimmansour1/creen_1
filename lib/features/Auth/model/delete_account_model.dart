// To parse this JSON data, do
//
//     final deleteAccountModel = deleteAccountModelFromJson(jsonString);

import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) =>
    DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) =>
    json.encode(data.toJson());

class DeleteAccountModel {
  DeleteAccountModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  bool? data;

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
        status: json["status"],
        message: json["message"],
        data: (json["data"] !)=="true"?true:false,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
