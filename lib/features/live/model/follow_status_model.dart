class FollowStatusModel {
  FollowStatusModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  bool? data;

  factory FollowStatusModel.fromJson(Map<String, dynamic> json) => FollowStatusModel(
    status: json["status"],
    message: json["message"],
    data: json["data"]   );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };

}
