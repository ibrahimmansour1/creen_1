class UserFollowers {
  UserFollowers({
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
  int? age;
  String? about;
  String? gender;
  int? levelId;
  int? countryId;
  int? cityId;
  String? language;
  int? invitationBy;
  String? month;
  dynamic emailVerifiedAt;
  int? numOfRating;
  String? rateAvg;
  bool? isFollow;
  String? fcmToken;
  int? programCount;

  factory UserFollowers.fromJson(Map<String, dynamic> json) => UserFollowers(
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
      };
}
