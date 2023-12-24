// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<City>? data;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<City>.from(json["data"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  int? id;
  int? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        countryId: json["country_id"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };
}
