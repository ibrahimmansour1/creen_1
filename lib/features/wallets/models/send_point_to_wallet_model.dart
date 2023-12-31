// To parse this JSON data, do
//
//     final transferPointsToWalletModel = transferPointsToWalletModelFromJson(jsonString);

import 'dart:convert';

TransferPointsToWalletModel transferPointsToWalletModelFromJson(String str) => TransferPointsToWalletModel.fromJson(json.decode(str));

String transferPointsToWalletModelToJson(TransferPointsToWalletModel data) => json.encode(data.toJson());

class TransferPointsToWalletModel {
    TransferPointsToWalletModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory TransferPointsToWalletModel.fromJson(Map<String, dynamic> json) => TransferPointsToWalletModel(
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
    });

    Wallets? wallets;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallets: json["wallets"] == null ? null : Wallets.fromJson(json["wallets"]),
    );

    Map<String, dynamic> toJson() => {
        "wallets": wallets?.toJson(),
    };
}

class Wallets {
    Wallets({
        this.userId,
        this.grandTotal,
        this.balance,
        this.operation,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.description,
    });

    int? userId;
    int? grandTotal;
    String? balance;
    int? operation;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;
    String? description;

    factory Wallets.fromJson(Map<String, dynamic> json) => Wallets(
        userId: json["user_id"],
        grandTotal: json["grand_total"],
        balance: json["balance"],
        operation: json["operation"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "grand_total": grandTotal,
        "balance": balance,
        "operation": operation,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "description": description,
    };
}
