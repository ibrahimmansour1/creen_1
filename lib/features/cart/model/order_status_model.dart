class OrderStatusModel {
  OrderStatusModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data{

  Data({
    this.id,
    this.code,
    this.user_send,
    this.user_receive,
    this.product_id,
    this.quantity,
    this.product_color_id,
    this.product_size_id,
    this.status,
    this.created_at,
    this.updated_at,
  });

  int? id;
  String? code;
int? user_send;
  int? user_receive ;
  int? product_id ;
  int? quantity ;
  int? product_color_id;
  int? product_size_id;
  String? status;
  String? created_at;
  String? updated_at;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id:json["id"] ,
    user_send: json["user_send"],
    user_receive: json["user_receive"],
    product_id: json["product_id"],
    quantity: json["quantity"],
    product_color_id: json["product_color_id"],
    product_size_id: json["product_size_id"],
    status: json["status"],
    created_at: json["created_at"],
    updated_at: json["updated_at"],
   );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "user_send": user_send,
    "user_receive": user_receive,
    "product_id": product_id,
    "quantity": quantity,
    "product_color_id": product_color_id,
    "product_size_id": product_size_id,
    "status": status,
    "created_at": created_at,
    "updated_at": updated_at,
  };

}