// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

AddToCartModel addToCartModelFromJson(String? str) =>
    AddToCartModel.fromJson(json.decode(str!));

String? addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());

class AddToCartModel {
  AddToCartModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
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
    this.cart,
  });

  Cart? cart;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "cart": cart?.toJson(),
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
        colors: List<dynamic>.from(json["colors"].map((x) => x)),
        sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
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
        "product": product?.toJson(),
        "colors": List<dynamic>.from(colors!.map((x) => x)),
        "sizes": List<dynamic>.from(sizes!.map((x) => x)),
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
  Image? image;
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
        image:json["image"]==null?null: Image.fromJson(json["image"]),
        details:json["details"]==null?null: Details.fromJson(json["details"]),
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
        "image": image?.toJson(),
        "details": details?.toJson(),
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

class Image {
  Image({
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

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
