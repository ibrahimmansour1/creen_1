import 'dart:convert';

DeleteCommentFromPostModel deleteCommentFromPostModelFromJson(String str) =>
    DeleteCommentFromPostModel.fromJson(json.decode(str));

String addCommentToPostModelToJson(DeleteCommentFromPostModel data) =>
    json.encode(data.toJson());

class DeleteCommentFromPostModel {
  bool status;
  String? message;
  String? data;

  DeleteCommentFromPostModel({
    this.status=true,
    this.message,
    this.data,
  });

  factory DeleteCommentFromPostModel.fromJson(Map<String, dynamic> json) =>
      DeleteCommentFromPostModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
