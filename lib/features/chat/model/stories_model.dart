// To parse this JSON data, do
//
//     final storiesModel = storiesModelFromJson(jsonString);

import 'dart:convert';

import 'story_data.dart';

StoriesModel storiesModelFromJson(String str) => StoriesModel.fromJson(json.decode(str));

String storiesModelToJson(StoriesModel data) => json.encode(data.toJson());

class StoriesModel {
    StoriesModel({
        this.status,
        this.message,
        this.data,
    });

    bool? status;
    String? message;
    Data? data;

    factory StoriesModel.fromJson(Map<String, dynamic> json) => StoriesModel(
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
        this.stories,
    });

    Stories? stories;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        stories: json["stories"] == null ? null : Stories.fromJson(json["stories"]),
    );

    Map<String, dynamic> toJson() => {
        "stories": stories?.toJson(),
    };
}

class Stories {
    Stories({
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
    List<StoryPublisher>? data;
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

    factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<StoryPublisher>.from(json["data"]!.map((x) => StoryPublisher.fromJson(x))),
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

class StoryPublisher {
    StoryPublisher({
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
        this.story,
    });

    int? id;
    String? name;
    String? mobile;
    String? email;
    String? profile;
    String? cover;
    dynamic address;
    int? age;
    dynamic about;
    String? gender;
    dynamic levelId;
    int? countryId;
    int? cityId;
    String? language;
    dynamic invitationBy;
    String? month;
    dynamic emailVerifiedAt;
    int? numOfRating;
    dynamic rateAvg;
    bool? isFollow;
    String? fcmToken;
    int? programCount;
    List<StoryData>? story;

    factory StoryPublisher.fromJson(Map<String, dynamic> json) => StoryPublisher(
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
        month: json["month"],
        emailVerifiedAt: json["email_verified_at"],
        numOfRating: json["num_of_rating"],
        rateAvg: json["rate_avg"],
        isFollow: json["is_follow"],
        fcmToken: json["fcm_token"],
        programCount: json["program_count"],
        story: json["story"] == null ? [] : List<StoryData>.from(json["story"]!.map((x) => StoryData.fromJson(x))),
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
        "month": month,
        "email_verified_at": emailVerifiedAt,
        "num_of_rating": numOfRating,
        "rate_avg": rateAvg,
        "is_follow": isFollow,
        "fcm_token": fcmToken,
        "program_count": programCount,
        "story": story == null ? [] : List<dynamic>.from(story!.map((x) => x.toJson())),
    };
}
