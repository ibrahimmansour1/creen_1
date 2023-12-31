// To parse this JSON data, do
//
//     final specificProductModel = specificProductModelFromJson(jsonString);

import 'dart:convert';

// SpecificProductModel specificProductModelFromJson(String? str) =>
//     SpecificProductModel.fromJson(json.decode(str));

String? specificProductModelToJson(SpecificProductModel data) =>
    json.encode(data.toJson());

class SpecificProductModel {
  SpecificProductModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  ProductData? data;

  factory SpecificProductModel.fromJson(Map<String, dynamic> json) =>
      SpecificProductModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductData {
  ProductData({
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
    this.imagesCount,
    this.commentsCount,
    this.likesCount,
    this.rates,
    this.isLike,
    this.images,
    this.image,
    this.video,
    this.category,
    this.user,
    this.details,
    this.colors,
    this.sizes,
    this.comments,
  });

  int? id;
  int? userId;
  int? categoryId;
  dynamic categoryParentId;
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
  int? imagesCount;
  int? commentsCount;
  int? likesCount;
  int? rates;
  bool? isLike;
  List<Images>? images;
  Images? image;
  String? video;
  Category? category;
  User? user;
  Details? details;
  List<Color>? colors;
  List<Color>? sizes;
  List<Comment>? comments;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
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
        createdAt: DateTime.parse(json["created_at"] ?? ''),
        updatedAt: DateTime.parse(json["updated_at"] ?? ''),
        imagesCount: json["images_count"],
        commentsCount: json["comments_count"],
        likesCount: json["likes_count"],
        rates: json["rates"],
        isLike: json["is_like"],
        images: json["images"] == null
            ? null
            : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        image: json["image"] == null ? null : Images.fromJson(json["image"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        colors: json["colors"] == null
            ? null
            : List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
        sizes: json["sizes"] == null
            ? null
            : List<Color>.from(json["sizes"].map((x) => Color.fromJson(x))),
        comments: json["comments"] == null
            ? null
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
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
        "images_count": imagesCount,
        "comments_count": commentsCount,
        "likes_count": likesCount,
        "rates": rates,
        "is_like": isLike,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "image": image?.toJson(),
        "category": category?.toJson(),
        "user": user?.toJson(),
        "details": details?.toJson(),
        "colors": List<dynamic>.from(colors!.map((x) => x.toJson())),
        "sizes": List<dynamic>.from(sizes!.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
      };
}

class Category {
  Category({
    this.id,
    this.slug,
    this.icon,
    this.color,
    this.keywords,
    this.description,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  int? id;
  dynamic slug;
  String? icon;
  dynamic color;
  dynamic keywords;
  dynamic description;
  int? parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        slug: json["slug"],
        icon: json["icon"],
        color: json["color"],
        keywords: json["keywords"],
        description: json["description"],
        parentId: json["parent_id"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "icon": icon,
        "color": color,
        "keywords": keywords,
        "description": description,
        "parent_id": parentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };
}

class Color {
  Color({
    this.id,
    this.productId,
    this.color,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.size,
  });

  int? id;
  int? productId;
  String? color;
  dynamic quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? size;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        id: json["id"],
        productId: json["product_id"],
        color: json["color"],
        quantity: json["quantity"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "color": color,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "size": size,
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
  int? shippingPrice;
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
        createdAt: DateTime.parse(json["created_at"] ?? ''),
        updatedAt: DateTime.parse(json["updated_at"] ?? ''),
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

class User {
  User({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.profile,
    this.cover,
    this.address,
    this.age,
    this.about,
    this.gender,
    this.levelId,
    this.countryId,
    this.cityId,
    this.language,
    this.invitationBy,
    this.month,
    this.emailVerifiedAt,
    this.numOfRating,
    this.rateAvg,
    this.isFollow,
    this.fcmToken,
    this.programCount,
    this.city,
  });

  int? id;
  String? name;
  String? mobile;
  String? email;
  String? profile;
  String? cover;
  dynamic address;
  dynamic age;
  String? about;
  String? gender;
  int? levelId;
  int? countryId;
  int? cityId;
  String? language;
  dynamic invitationBy;
  DateTime? month;
  dynamic emailVerifiedAt;
  int? numOfRating;
  String? rateAvg;
  bool? isFollow;
  String? fcmToken;
  int? programCount;
  City? city;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        profile: json["profile"],
        cover: json["cover"],
        address: json["address"],
        age: json["age"],
        about: json["about"],
        gender: json["gender"],
        levelId: json["level_id"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        language: json["language"],
        invitationBy: json["invitation_by"],
        month: DateTime.tryParse(json["month"] ?? ''),
        emailVerifiedAt: json["email_verified_at"],
        numOfRating: json["num_of_rating"],
        rateAvg: json["rate_avg"],
        isFollow: json["is_follow"],
        fcmToken: json["fcm_token"],
        programCount: json["program_count"],
        city: json["city"] == null ? null : City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "profile": profile,
        "cover": cover,
        "address": address,
        "age": age,
        "about": about,
        "gender": gender,
        "level_id": levelId,
        "country_id": countryId,
        "city_id": cityId,
        "language": language,
        "invitation_by": invitationBy,
        "month": month?.toIso8601String(),
        "email_verified_at": emailVerifiedAt,
        "num_of_rating": numOfRating,
        "rate_avg": rateAvg,
        "is_follow": isFollow,
        "fcm_token": fcmToken,
        "program_count": programCount,
        "city": city?.toJson(),
      };
}

class City {
  City({
    this.id,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.country,
  });

  int? id;
  int? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  Country? country;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        countryId: json["country_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "country": country?.toJson(),
      };
}

class Country {
  Country({
    this.id,
    this.countryCode,
    this.phonecode,
    this.currency,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  int? id;
  String? countryCode;
  int? phonecode;
  String? currency;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        countryCode: json["country_code"],
        phonecode: json["phonecode"],
        currency: json["currency"],
        language: json["language"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_code": countryCode,
        "phonecode": phonecode,
        "currency": currency,
        "language": language,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };
}

class Comment {
  Comment({
    this.id,
    this.productId,
    this.userId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? productId;
  int? userId;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        productId: json["product_id"],
        userId: json["user_id"],
        comment: json["comment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}
