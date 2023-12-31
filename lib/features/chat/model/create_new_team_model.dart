// To parse this JSON data, do
//
//     final createNewTeamModel = createNewTeamModelFromJson(jsonString);

import 'dart:convert';

CreateNewTeamModel createNewTeamModelFromJson(String str) => CreateNewTeamModel.fromJson(json.decode(str));

String createNewTeamModelToJson(CreateNewTeamModel data) => json.encode(data.toJson());

class CreateNewTeamModel {
    bool? status;
    String? message;
    Data? data;

    CreateNewTeamModel({
        this.status,
        this.message,
        this.data,
    });

    factory CreateNewTeamModel.fromJson(Map<String, dynamic> json) => CreateNewTeamModel(
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
    Chat? chat;
    Message? message;

    Data({
        this.chat,
        this.message,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "chat": chat?.toJson(),
        "message": message?.toJson(),
    };
}

class Chat {
    int? userId;
    int? teamCode;
    int? activate;
    String? name;
    String? logo;
    int? id;
    String? timeAgo;

    Chat({
        this.userId,
        this.teamCode,
        this.activate,
        this.name,
        this.logo,
        this.id,
        this.timeAgo,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        userId: json["user_id"],
        teamCode: json["team_code"],
        activate: json["activate"],
        name: json["name"],
        logo: json["logo"],
        id: json["id"],
        timeAgo: json["time_ago"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "team_code": teamCode,
        "activate": activate,
        "name": name,
        "logo": logo,
        "id": id,
        "time_ago": timeAgo,
    };
}

class Message {
    int? chatId;
    String? status;
    int? userId;
    String? userName;
    String? description;
    int? id;
    String? timeAgo;

    Message({
        this.chatId,
        this.status,
        this.userId,
        this.userName,
        this.description,
        this.id,
        this.timeAgo,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        chatId: json["chat_id"],
        status: json["status"],
        userId: json["user_id"],
        userName: json["user_name"],
        description: json["description"],
        id: json["id"],
        timeAgo: json["time_ago"],
    );

    Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "status": status,
        "user_id": userId,
        "user_name": userName,
        "description": description,
        "id": id,
        "time_ago": timeAgo,
    };
}
