// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Categories>? data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Categories>.from(
                json["data"].map((x) => Categories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Categories {
  Categories({
    this.id,
    this.sort,
    this.slug,
    this.icon,
    this.image,
    this.color,
    this.keywords,
    this.description,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  int? id;
  int? sort;
  String? slug;
  String? icon;
  String? image;
  dynamic color;
  String? keywords;
  String? description;
  dynamic parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        sort: json["sort"],
        slug: json["slug"],
        icon: json["icon"],
        image: json["image"],
        color: json["color"],
        keywords: json["keywords"],
        description: json["description"],
        parentId: json["parent_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sort": sort,
        "slug": slug,
        "icon": icon,
        "image": image,
        "color": color,
        "keywords": keywords,
        "description": description,
        "parent_id": parentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };
}
