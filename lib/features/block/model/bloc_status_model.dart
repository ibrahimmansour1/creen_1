
class BlocStatusModel{
  BlocStatusModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  dynamic message;
  dynamic data;

  factory BlocStatusModel.fromJson(Map<String, dynamic> json) => BlocStatusModel(
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