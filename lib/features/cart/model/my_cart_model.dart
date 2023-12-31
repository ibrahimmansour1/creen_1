// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel? cartModelFromJson(String str) =>
    CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel? data) => json.encode(data!.toJson());

class CartModel {
  CartModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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

class Data {
  Data({
    this.carts,
  });

  List<Cart>? carts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        carts: json["carts"] == null
            ? []
            : List<Cart>.from(json["carts"]!.map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "carts": carts == null
            ? []
            : List<dynamic>.from(carts!.map((x) => x.toJson())),
      };
}

class Cart {
  Cart({
    this.id,
    this.productId,
    this.userId,
    this.quantity,
    this.productColorId,
    this.productSizeId,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.colors,
    this.sizes,
  });

  int? id;
  int? productId;
  int? userId;
  int? quantity;
  dynamic productColorId;
  dynamic productSizeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;
  List<dynamic>? colors;
  List<dynamic>? sizes;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        quantity: json["quantity"],
        productColorId: json["product_color_id"],
        productSizeId: json["product_size_id"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        colors: json["colors"] == null
            ? []
            : List<dynamic>.from(json["colors"]!.map((x) => x)),
        sizes: json["sizes"] == null
            ? []
            : List<dynamic>.from(json["sizes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "quantity": quantity,
        "product_color_id": productColorId,
        "product_size_id": productSizeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product!.toJson(),
        "colors":
            colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
        "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x)),
      };
}

class Product {
  Product({
    this.id,
    this.userId,
    this.categoryId,
    this.categoryParentId,
    this.brandId,
    this.code,
    this.title,
    this.price,
    this.description,
    this.seen,
    this.special,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.rates,
    this.isLike,
    this.image,
    this.details,
  });

  int? id;
  int? userId;
  int? categoryId;
  int? categoryParentId;
  dynamic brandId;
  String? code;
  String? title;
  int? price;
  String? description;
  int? seen;
  int? special;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? rates;
  bool? isLike;
  Images? image;
  Details? details;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        categoryParentId: json["category_parent_id"],
        brandId: json["brand_id"],
        code: json["code"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        seen: json["seen"],
        special: json["special"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        rates: json["rates"],
        isLike: json["is_like"],
        image: json["image"] == null ? null : Images.fromJson(json["image"]),
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "category_parent_id": categoryParentId,
        "brand_id": brandId,
        "code": code,
        "title": title,
        "price": price,
        "description": description,
        "seen": seen,
        "special": special,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rates": rates,
        "is_like": isLike,
        "image": image!.toJson(),
        "details": details!.toJson(),
      };
}

class Details {
  Details({
    this.id,
    this.productId,
    this.video,
    this.color,
    this.quantity,
    this.weight,
    this.shippingPrice,
    this.status,
    this.payment,
    this.whatsapp,
    this.keywords,
    this.hiddenData,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? productId;
  String? video;
  dynamic color;
  int? quantity;
  dynamic weight;
  dynamic shippingPrice;
  String? status;
  String? payment;
  String? whatsapp;
  String? keywords;
  dynamic hiddenData;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        productId: json["product_id"],
        video: json["video"],
        color: json["color"],
        quantity: json["quantity"],
        weight: json["weight"],
        shippingPrice: json["shipping_price"],
        status: json["status"],
        payment: json["payment"],
        whatsapp: json["whatsapp"],
        keywords: json["keywords"],
        hiddenData: json["hidden_data"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "video": video,
        "color": color,
        "quantity": quantity,
        "weight": weight,
        "shipping_price": shippingPrice,
        "status": status,
        "payment": payment,
        "whatsapp": whatsapp,
        "keywords": keywords,
        "hidden_data": hiddenData,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Images {
  Images({
    this.id,
    this.filename,
    this.originalFilename,
    this.url,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? filename;
  String? originalFilename;
  String? url;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        filename: json["filename"],
        originalFilename: json["original_filename"],
        url: json["url"],
        productId: json["product_id"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "original_filename": originalFilename,
        "url": url,
        "product_id": productId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class OrderModel {
  OrderModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Order? data;
}

class Order {
  int order_id;
  Human? sender;
  Human? receiver;
  String? payment_method;
  String? order_status;
  String? time_ago;
  String? price;
  OrderDetails? order_details;

  Order({
    required this.order_id,
    this.sender,
    this.receiver,
    this.payment_method,
    this.order_status,
    this.time_ago,
    this.price,
    this.order_details,
  });
}

class Human {
  int id;
  String name;
  String? profile;
  String? mobile;
  String email;
  String? address;
  int country;
  int city;

  Human({
    required this.id,
    required this.name,
    this.profile,
    this.mobile,
    required this.email,
    this.address,
    required this.country,
    required this.city,
  });
}

class OrderDetails {
  Product? products;
  double? reset_number;
  double? tex_number;

  OrderDetails({
    required this.products,
    this.reset_number,
    this.tex_number,
  });
}
