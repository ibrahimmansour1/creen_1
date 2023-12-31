// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'dart:convert';

CountriesModel countriesModelFromJson(String str) =>
    CountriesModel.fromJson(json.decode(str));

String countriesModelToJson(CountriesModel data) => json.encode(data.toJson());

class CountriesModel {
  CountriesModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Countries>? data;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<Countries>.from(
                json["data"].map((x) => Countries.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Countries {
  Countries({
    this.id,
    this.countryCode,
    this.phoneCode,
    this.currency,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  int? id;
  String? countryCode;
  int? phoneCode;
  String? currency;
  String? language;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        id: json["id"],
        countryCode: json["country_code"],
        phoneCode: json["phonecode"],
        currency: json["currency"],
        language: json["language"],
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
        "country_code": countryCode,
        "phonecode": phoneCode,
        "currency": currency,
        "language": language,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };
}
