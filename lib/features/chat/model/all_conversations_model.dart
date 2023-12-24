// To parse this JSON data, do
//
//     final allConversationsModel = allConversationsModelFromJson(jsonString);

import 'dart:convert';

AllConversationsModel allConversationsModelFromJson(String str) =>
    AllConversationsModel.fromJson(json.decode(str));

String allConversationsModelToJson(AllConversationsModel data) =>
    json.encode(data.toJson());

class AllConversationsModel {
  AllConversationsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AllConversationsModel.fromJson(Map<String, dynamic> json) =>
      AllConversationsModel(
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
    this.title,
    this.users,
    this.chats,
  });

  String? title;
  Users? users;
  Chats? chats;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        chats: json["chats"] == null ? null : Chats.fromJson(json["chats"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "users": users,
        "chats": chats?.toJson(),
      };
}

class Chats {
  Chats({
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
  List<Conversation>? data;
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

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Conversation>.from(
                json["data"]!.map((x) => Conversation.fromJson(x))),
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

class Conversation {
  Conversation({
    this.id,
    this.userId,
    this.teamCode,
    this.activate,
    this.reciever,
    this.name,
    this.logo,
    this.deletedAt,
    this.timeAgo,
    this.lmessage,
    this.recieverm,
    this.sender,
    this.status,
  });

  int? id;
  int? userId;
  dynamic teamCode;
  int? activate;
  int? reciever;
  dynamic name;
  dynamic logo;
  dynamic deletedAt;
  String? timeAgo;
  String? status;
  Lmessage? lmessage;
  Recieverm? recieverm;
  Recieverm? sender;

  factory Conversation.fromJson(Map<String, dynamic> json) {
    // print("json   =====> ${json}");

    return Conversation(
      id: json["id"],
      userId: json["user_id"],
      teamCode: json["team_code"],
      activate: json["activate"],
      reciever: json["reciever"],
      name: json["name"],
      logo: json["logo"],
      deletedAt: json["deleted_at"],
      status: json["status"],
      recieverm: json["recieverm"] == null
          ? null
          : Recieverm.fromJson(json["recieverm"]),
      sender: json["sender"] == null
          ? null
          : Recieverm.fromJson(json["sender"]),
      timeAgo: json["time_ago"],
      lmessage:
          json["lmessage"] == null ? null : Lmessage.fromJson(json["lmessage"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "team_code": teamCode,
        "activate": activate,
        "reciever": reciever,
        "name": name,
        "recieverm": recieverm?.toJson(),
        "logo": logo,
        "deleted_at": deletedAt,
        "time_ago": timeAgo,
        "lmessage": lmessage?.toJson(),
      };
}

class Lmessage {
  Lmessage({
    this.id,
    this.userId,
    this.userName,
    this.chatId,
    this.image,
    this.description,
    this.status,
    this.senderId,
    this.record,
    this.pdf,
    this.deletedAt,
    this.timeAgo,
  });

  int? id;
  int? userId;
  String? userName;
  int? chatId;
  dynamic image;
  String? description;
  String? status;
  int? senderId;
  dynamic record;
  dynamic pdf;
  dynamic deletedAt;
  String? timeAgo;

  factory Lmessage.fromJson(Map<String, dynamic> json) => Lmessage(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        chatId: json["chat_id"],
        image: json["image"],
        description: json["description"],
        status: json["status"],
        senderId: json["sender_id"],
        record: json["record"],
        pdf: json["pdf"],
        deletedAt: json["deleted_at"],
        timeAgo: json["time_ago"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "chat_id": chatId,
        "image": image,
        "description": description,
        "status": status,
        "sender_id": senderId,
        "record": record,
        "pdf": pdf,
        "deleted_at": deletedAt,
        "time_ago": timeAgo,
      };
}

class Recieverm {
  Recieverm({
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

  factory Recieverm.fromJson(Map<String, dynamic> json) => Recieverm(
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
        month: json["month"] == null ? null : DateTime.parse(json["month"]),
        emailVerifiedAt: json["email_verified_at"],
        numOfRating: json["num_of_rating"],
        rateAvg: json["rate_avg"],
        isFollow: json["is_follow"],
        fcmToken: json["fcm_token"],
        programCount: json["program_count"],
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
      };
}

class Users {
  int? currentPage;
  List<UsersDatum>? data;
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

  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<UsersDatum>.from(
                json["data"]!.map((x) => UsersDatum.fromJson(x))),
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

class UsersDatum {
  int? id;
  int? userId;
  int? categoryId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Recieverm? user;

  UsersDatum({
    this.id,
    this.userId,
    this.categoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory UsersDatum.fromJson(Map<String, dynamic> json) => UsersDatum(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : Recieverm.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
      };
}
