// To parse this JSON data, do
//
//     final walletsModel = walletsModelFromJson(jsonString);

import 'dart:convert';

WalletsModel walletsModelFromJson(String str) =>
    WalletsModel.fromJson(json.decode(str));

String walletsModelToJson(WalletsModel data) => json.encode(data.toJson());

class WalletsModel {
  WalletsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory WalletsModel.fromJson(Map<String, dynamic> json) => WalletsModel(
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
    this.wallets,
    this.total,
    this.walletFromPoint,
    this.walletFromGift,
  });

  Wallets? wallets;
  num? total;
  num? walletFromPoint;
  num? walletFromGift;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallets:
            json["wallets"] == null ? null : Wallets.fromJson(json["wallets"]),
        total: json["total"],
        walletFromPoint: json["walletFromPoint"],
        walletFromGift: json["walletFromGift"],
      );

  Map<String, dynamic> toJson() => {
        "wallets": wallets?.toJson(),
        "total": total,
        "walletFromPoint": walletFromPoint,
        "walletFromGift": walletFromGift,
      };
}

class Wallets {
  Wallets({
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
  List<WalletData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Wallets.fromJson(Map<String, dynamic> json) => Wallets(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<WalletData>.from(json["data"]!.map((x) => WalletData.fromJson(x))),
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
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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

class WalletData {
  WalletData({
    this.id,
    this.userId,
    this.grandTotal,
    this.balance,
    this.operation,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  int? id;
  int? userId;
  num? grandTotal;
  num? balance;
  num? operation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? description;

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        id: json["id"],
        userId: json["user_id"],
        grandTotal: json["grand_total"],
        balance: json["balance"],
        operation: json["operation"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "grand_total": grandTotal,
        "balance": balance,
        "operation": operation,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "description": description,
      };
}
