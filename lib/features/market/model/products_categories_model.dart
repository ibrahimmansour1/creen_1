// To parse this JSON data, do
//
//     final productCategoriesModel = productCategoriesModelFromJson(jsonString);

import 'dart:convert';

ProductCategoriesModel productCategoriesModelFromJson(String str) => ProductCategoriesModel.fromJson(json.decode(str));

String productCategoriesModelToJson(ProductCategoriesModel data) => json.encode(data.toJson());

class ProductCategoriesModel {
    ProductCategoriesModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory ProductCategoriesModel.fromJson(Map<String, dynamic> json) => ProductCategoriesModel(
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
        this.categories,
    });

    Categories? categories;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null ? null : Categories.fromJson(json["categories"]),
    );

    Map<String, dynamic> toJson() => {
        "categories": categories?.toJson(),
    };
}

class Categories {
    Categories({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    int? currentPage;
    List<ProductsCategory>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<ProductsCategory>.from(json["data"]!.map((x) => ProductsCategory.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class ProductsCategory {
    ProductsCategory({
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
        this.children,
    });

    int? id;
    String? slug;
    String? icon;
    dynamic color;
    dynamic keywords;
    dynamic description;
    int? parentId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? name;
    List<ProductsCategory>? children;

    factory ProductsCategory.fromJson(Map<String, dynamic> json) => ProductsCategory(
        id: json["id"],
        slug: json["slug"],
        icon: json["icon"],
        color: json["color"],
        keywords: json["keywords"],
        description: json["description"],
        parentId: json["parent_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        name: json["name"],
        children: json["children"] == null ? [] : List<ProductsCategory>.from(json["children"]!.map((x) => ProductsCategory.fromJson(x))),
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
        "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    };
}
