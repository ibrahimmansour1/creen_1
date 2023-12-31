class BlockModel {
  BlockModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  dynamic data;

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
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