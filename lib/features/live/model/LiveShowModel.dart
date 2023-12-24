import 'package:creen/features/live/model/MaincommentData.dart';
import 'package:creen/features/live/model/live_model.dart';

/// status : true
/// message : "app.lives"
/// data : {"LiveDataModel":{"lives":{"id":308,"title":"test","description":null,"join_method":"public","attendance_view":"public","attendance_share":"sound","link_share":"public","comments":"public","gifts":"public","type":"video","user_id":2,"image":"http://www.creen-program.com/storage/users/phpwNIOfY.png","filename":null,"live_id":null,"live_link":null,"youtube_link":null,"likes":1,"updated_at":"2023-12-07 09:04:32","time_ago":"1 hour ago","creator":{"id":2,"name":"د.محمد حمد العمري","mobile":"966536337733","email":"mmh3_r@hotmail.com","profile":"http://www.creen-program.com/storage/users/phpwNIOfY.png","cover":"http://www.creen-program.com/storage/users/phpWi3GlY.jpg","address":null,"age":null,"about":"اهتم بالتطوير وصناعة الأبحاث العلمية في أغلب المجالات التي أراها مناسبة لي\r\n \r\nأطمح للتطوير المستمر \r\n\r\n\r\nرسالتي واضحة ونحو القمة نسير\r\n\r\n.","gender":"male","level_id":1,"country_id":1,"city_id":1,"language":"ar","invitation_by":null,"month":"2022-06-21 22:20:07","email_verified_at":null,"num_of_rating":10,"rate_avg":"3.1000","is_follow":true,"fcm_token":"c_7jWSUfQ0a7n1kFtHSAaX:APA91bG6X45ylwTCb5YD7qpRkCXfR0g86Akw3ECrzGnObVlwFgOo-8ywgFEFSduPzx2ja0D3NCzfW7ZgqKtTgZDCgfCLWjXxWj7flh3vu3B_dqtQ5Mqmeum9LN0RBGdEz03zscS44CmJ","program_count":18}},"raisehands":[]},"maincomments":{"current_page":1,"maincommentData":[{"id":190,"user_id":11720,"comment":"user","live_id":308,"updated_at":"2023-12-07 09:01:46","time_ago":"5 minutes ago"}],"first_page_url":"https://creen-program.com/api/live/show?page=1","from":1,"last_page":1,"last_page_url":"https://creen-program.com/api/live/show?page=1","next_page_url":null,"path":"https://creen-program.com/api/live/show","per_page":5,"prev_page_url":null,"to":1,"total":1},"users":{"current_page":1,"userData":[{"id":512,"live_id":308,"user_id":2,"name":null,"mic":0,"camera":0,"sound":0,"priveleges":"creator","updated_at":"2023-12-07 08:07:34","comment":0,"gift":0,"userpublic":0,"chat":0,"remote_id":null,"time_ago":"1 hour ago","user":{"id":2,"name":"د.محمد حمد العمري","mobile":"966536337733","email":"mmh3_r@hotmail.com","profile":"http://www.creen-program.com/storage/users/phpwNIOfY.png","cover":"http://www.creen-program.com/storage/users/phpWi3GlY.jpg","address":null,"age":null,"about":"اهتم بالتطوير وصناعة الأبحاث العلمية في أغلب المجالات التي أراها مناسبة لي\r\n \r\nأطمح للتطوير المستمر \r\n\r\n\r\nرسالتي واضحة ونحو القمة نسير\r\n\r\n.","gender":"male","level_id":1,"country_id":1,"city_id":1,"language":"ar","invitation_by":null,"month":"2022-06-21 22:20:07","email_verified_at":null,"num_of_rating":10,"rate_avg":"3.1000","is_follow":true,"fcm_token":"c_7jWSUfQ0a7n1kFtHSAaX:APA91bG6X45ylwTCb5YD7qpRkCXfR0g86Akw3ECrzGnObVlwFgOo-8ywgFEFSduPzx2ja0D3NCzfW7ZgqKtTgZDCgfCLWjXxWj7flh3vu3B_dqtQ5Mqmeum9LN0RBGdEz03zscS44CmJ","program_count":18}}],"first_page_url":"https://creen-program.com/api/live/show?page=1","from":1,"last_page":1,"last_page_url":"https://creen-program.com/api/live/show?page=1","next_page_url":null,"path":"https://creen-program.com/api/live/show","per_page":5,"prev_page_url":null,"to":1,"total":1}}

class LiveShowModel {
  LiveShowModel({
      this.status,
      this.message,
      this.data,});

  LiveShowModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;
LiveShowModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => LiveShowModel(  status: status ?? this.status,
  message: message ?? this.message,
  data: data ?? this.data,
);
/*
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
*/

}

/// LiveDataModel : {"lives":{"id":308,"title":"test","description":null,"join_method":"public","attendance_view":"public","attendance_share":"sound","link_share":"public","comments":"public","gifts":"public","type":"video","user_id":2,"image":"http://www.creen-program.com/storage/users/phpwNIOfY.png","filename":null,"live_id":null,"live_link":null,"youtube_link":null,"likes":1,"updated_at":"2023-12-07 09:04:32","time_ago":"1 hour ago","creator":{"id":2,"name":"د.محمد حمد العمري","mobile":"966536337733","email":"mmh3_r@hotmail.com","profile":"http://www.creen-program.com/storage/users/phpwNIOfY.png","cover":"http://www.creen-program.com/storage/users/phpWi3GlY.jpg","address":null,"age":null,"about":"اهتم بالتطوير وصناعة الأبحاث العلمية في أغلب المجالات التي أراها مناسبة لي\r\n \r\nأطمح للتطوير المستمر \r\n\r\n\r\nرسالتي واضحة ونحو القمة نسير\r\n\r\n.","gender":"male","level_id":1,"country_id":1,"city_id":1,"language":"ar","invitation_by":null,"month":"2022-06-21 22:20:07","email_verified_at":null,"num_of_rating":10,"rate_avg":"3.1000","is_follow":true,"fcm_token":"c_7jWSUfQ0a7n1kFtHSAaX:APA91bG6X45ylwTCb5YD7qpRkCXfR0g86Akw3ECrzGnObVlwFgOo-8ywgFEFSduPzx2ja0D3NCzfW7ZgqKtTgZDCgfCLWjXxWj7flh3vu3B_dqtQ5Mqmeum9LN0RBGdEz03zscS44CmJ","program_count":18}},"raisehands":[]}
/// maincomments : {"current_page":1,"maincommentData":[{"id":190,"user_id":11720,"comment":"user","live_id":308,"updated_at":"2023-12-07 09:01:46","time_ago":"5 minutes ago"}],"first_page_url":"https://creen-program.com/api/live/show?page=1","from":1,"last_page":1,"last_page_url":"https://creen-program.com/api/live/show?page=1","next_page_url":null,"path":"https://creen-program.com/api/live/show","per_page":5,"prev_page_url":null,"to":1,"total":1}
/// users : {"current_page":1,"userData":[{"id":512,"live_id":308,"user_id":2,"name":null,"mic":0,"camera":0,"sound":0,"priveleges":"creator","updated_at":"2023-12-07 08:07:34","comment":0,"gift":0,"userpublic":0,"chat":0,"remote_id":null,"time_ago":"1 hour ago","user":{"id":2,"name":"د.محمد حمد العمري","mobile":"966536337733","email":"mmh3_r@hotmail.com","profile":"http://www.creen-program.com/storage/users/phpwNIOfY.png","cover":"http://www.creen-program.com/storage/users/phpWi3GlY.jpg","address":null,"age":null,"about":"اهتم بالتطوير وصناعة الأبحاث العلمية في أغلب المجالات التي أراها مناسبة لي\r\n \r\nأطمح للتطوير المستمر \r\n\r\n\r\nرسالتي واضحة ونحو القمة نسير\r\n\r\n.","gender":"male","level_id":1,"country_id":1,"city_id":1,"language":"ar","invitation_by":null,"month":"2022-06-21 22:20:07","email_verified_at":null,"num_of_rating":10,"rate_avg":"3.1000","is_follow":true,"fcm_token":"c_7jWSUfQ0a7n1kFtHSAaX:APA91bG6X45ylwTCb5YD7qpRkCXfR0g86Akw3ECrzGnObVlwFgOo-8ywgFEFSduPzx2ja0D3NCzfW7ZgqKtTgZDCgfCLWjXxWj7flh3vu3B_dqtQ5Mqmeum9LN0RBGdEz03zscS44CmJ","program_count":18}}],"first_page_url":"https://creen-program.com/api/live/show?page=1","from":1,"last_page":1,"last_page_url":"https://creen-program.com/api/live/show?page=1","next_page_url":null,"path":"https://creen-program.com/api/live/show","per_page":5,"prev_page_url":null,"to":1,"total":1}

class Data {
  Data({
      this.liveDataModel,
      this.maincomments,
      this.users,});

  Data.fromJson(dynamic json) {
    liveDataModel = json['lives'] != null ? LiveDataModel.fromJson(json['lives']) : null;
    maincomments = json['maincomments'] != null ? Maincomments.fromJson(json['maincomments']) : null;
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }
  LiveDataModel? liveDataModel;
  Maincomments? maincomments;
  Users? users;
Data copyWith({  LiveDataModel? liveDataModel,
  Maincomments? maincomments,
  Users? users,
}) => Data(  liveDataModel: liveDataModel ?? this.liveDataModel,
  maincomments: maincomments ?? this.maincomments,
  users: users ?? this.users,
);
/*
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (liveDataModel != null) {
      map['LiveDataModel'] = liveDataModel?.toJson();
    }
    if (maincomments != null) {
      map['maincomments'] = maincomments?.toJson();
    }
    if (users != null) {
      map['users'] = users?.toJson();
    }
    return map;
  }
*/

}

/// current_page : 1
/// userData : [{"id":512,"live_id":308,"user_id":2,"name":null,"mic":0,"camera":0,"sound":0,"priveleges":"creator","updated_at":"2023-12-07 08:07:34","comment":0,"gift":0,"userpublic":0,"chat":0,"remote_id":null,"time_ago":"1 hour ago","user":{"id":2,"name":"د.محمد حمد العمري","mobile":"966536337733","email":"mmh3_r@hotmail.com","profile":"http://www.creen-program.com/storage/users/phpwNIOfY.png","cover":"http://www.creen-program.com/storage/users/phpWi3GlY.jpg","address":null,"age":null,"about":"اهتم بالتطوير وصناعة الأبحاث العلمية في أغلب المجالات التي أراها مناسبة لي\r\n \r\nأطمح للتطوير المستمر \r\n\r\n\r\nرسالتي واضحة ونحو القمة نسير\r\n\r\n.","gender":"male","level_id":1,"country_id":1,"city_id":1,"language":"ar","invitation_by":null,"month":"2022-06-21 22:20:07","email_verified_at":null,"num_of_rating":10,"rate_avg":"3.1000","is_follow":true,"fcm_token":"c_7jWSUfQ0a7n1kFtHSAaX:APA91bG6X45ylwTCb5YD7qpRkCXfR0g86Akw3ECrzGnObVlwFgOo-8ywgFEFSduPzx2ja0D3NCzfW7ZgqKtTgZDCgfCLWjXxWj7flh3vu3B_dqtQ5Mqmeum9LN0RBGdEz03zscS44CmJ","program_count":18}}]
/// first_page_url : "https://creen-program.com/api/live/show?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://creen-program.com/api/live/show?page=1"
/// next_page_url : null
/// path : "https://creen-program.com/api/live/show"
/// per_page : 5
/// prev_page_url : null
/// to : 1
/// total : 1

class Users {
  Users({
      this.currentPage,
      this.userData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,});

  Users.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      userData = [];
      json['data'].forEach((v) {
        userData?.add(LiveUser.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<LiveUser>? userData;
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
Users copyWith({  int? currentPage,
  List<LiveUser>? userData,
  String? firstPageUrl,
  int? from,
  int? lastPage,
  String? lastPageUrl,
  dynamic nextPageUrl,
  String? path,
  int? perPage,
  dynamic prevPageUrl,
  int? to,
  int? total,
}) => Users(  currentPage: currentPage ?? this.currentPage,
  userData: userData ?? this.userData,
  firstPageUrl: firstPageUrl ?? this.firstPageUrl,
  from: from ?? this.from,
  lastPage: lastPage ?? this.lastPage,
  lastPageUrl: lastPageUrl ?? this.lastPageUrl,
  nextPageUrl: nextPageUrl ?? this.nextPageUrl,
  path: path ?? this.path,
  perPage: perPage ?? this.perPage,
  prevPageUrl: prevPageUrl ?? this.prevPageUrl,
  to: to ?? this.to,
  total: total ?? this.total,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
   /* if (userData != null) {
      map['userData'] = userData?.map((v) => v.toJson()).toList();
    }*/
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}

/// id : 512
/// live_id : 308
/// user_id : 2
/// name : null
/// mic : 0
/// camera : 0
/// sound : 0
/// priveleges : "creator"
/// updated_at : "2023-12-07 08:07:34"
/// comment : 0
/// gift : 0
/// userpublic : 0
/// chat : 0
/// remote_id : null
/// time_ago : "1 hour ago"
/// user : {"id":2,"name":"د.محمد حمد العمري","mobile":"966536337733","email":"mmh3_r@hotmail.com","profile":"http://www.creen-program.com/storage/users/phpwNIOfY.png","cover":"http://www.creen-program.com/storage/users/phpWi3GlY.jpg","address":null,"age":null,"about":"اهتم بالتطوير وصناعة الأبحاث العلمية في أغلب المجالات التي أراها مناسبة لي\r\n \r\nأطمح للتطوير المستمر \r\n\r\n\r\nرسالتي واضحة ونحو القمة نسير\r\n\r\n.","gender":"male","level_id":1,"country_id":1,"city_id":1,"language":"ar","invitation_by":null,"month":"2022-06-21 22:20:07","email_verified_at":null,"num_of_rating":10,"rate_avg":"3.1000","is_follow":true,"fcm_token":"c_7jWSUfQ0a7n1kFtHSAaX:APA91bG6X45ylwTCb5YD7qpRkCXfR0g86Akw3ECrzGnObVlwFgOo-8ywgFEFSduPzx2ja0D3NCzfW7ZgqKtTgZDCgfCLWjXxWj7flh3vu3B_dqtQ5Mqmeum9LN0RBGdEz03zscS44CmJ","program_count":18}

class UserData {
  UserData({
      this.id,
      this.liveId,
      this.userId,
      this.name,
      this.mic,
      this.camera,
      this.sound,
      this.priveleges,
      this.updatedAt,
      this.comment,
      this.gift,
      this.userpublic,
      this.chat,
      this.remoteId,
      this.timeAgo,
      this.user,});

  UserData.fromJson(dynamic json) {
    id = json['id'];
    liveId = json['live_id'];
    userId = json['user_id'];
    name = json['name'];
    mic = json['mic'];
    camera = json['camera'];
    sound = json['sound'];
    priveleges = json['priveleges'];
    updatedAt = json['updated_at'];
    comment = json['comment'];
    gift = json['gift'];
    userpublic = json['userpublic'];
    chat = json['chat'];
    remoteId = json['remote_id'];
    timeAgo = json['time_ago'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? id;
  int? liveId;
  int? userId;
  dynamic name;
  int? mic;
  int? camera;
  int? sound;
  String? priveleges;
  String? updatedAt;
  int? comment;
  int? gift;
  int? userpublic;
  int? chat;
  dynamic remoteId;
  String? timeAgo;
  User? user;
UserData copyWith({  int? id,
  int? liveId,
  int? userId,
  dynamic name,
  int? mic,
  int? camera,
  int? sound,
  String? priveleges,
  String? updatedAt,
  int? comment,
  int? gift,
  int? userpublic,
  int? chat,
  dynamic remoteId,
  String? timeAgo,
  User? user,
}) => UserData(  id: id ?? this.id,
  liveId: liveId ?? this.liveId,
  userId: userId ?? this.userId,
  name: name ?? this.name,
  mic: mic ?? this.mic,
  camera: camera ?? this.camera,
  sound: sound ?? this.sound,
  priveleges: priveleges ?? this.priveleges,
  updatedAt: updatedAt ?? this.updatedAt,
  comment: comment ?? this.comment,
  gift: gift ?? this.gift,
  userpublic: userpublic ?? this.userpublic,
  chat: chat ?? this.chat,
  remoteId: remoteId ?? this.remoteId,
  timeAgo: timeAgo ?? this.timeAgo,
  user: user ?? this.user,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['live_id'] = liveId;
    map['user_id'] = userId;
    map['name'] = name;
    map['mic'] = mic;
    map['camera'] = camera;
    map['sound'] = sound;
    map['priveleges'] = priveleges;
    map['updated_at'] = updatedAt;
    map['comment'] = comment;
    map['gift'] = gift;
    map['userpublic'] = userpublic;
    map['chat'] = chat;
    map['remote_id'] = remoteId;
    map['time_ago'] = timeAgo;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// id : 2
/// name : "د.محمد حمد العمري"
/// mobile : "966536337733"
/// email : "mmh3_r@hotmail.com"
/// profile : "http://www.creen-program.com/storage/users/phpwNIOfY.png"
/// cover : "http://www.creen-program.com/storage/users/phpWi3GlY.jpg"
/// address : null
/// age : null
/// about : "اهتم بالتطوير وصناعة الأبحاث العلمية في أغلب المجالات التي أراها مناسبة لي\r\n \r\nأطمح للتطوير المستمر \r\n\r\n\r\nرسالتي واضحة ونحو القمة نسير\r\n\r\n."
/// gender : "male"
/// level_id : 1
/// country_id : 1
/// city_id : 1
/// language : "ar"
/// invitation_by : null
/// month : "2022-06-21 22:20:07"
/// email_verified_at : null
/// num_of_rating : 10
/// rate_avg : "3.1000"
/// is_follow : true
/// fcm_token : "c_7jWSUfQ0a7n1kFtHSAaX:APA91bG6X45ylwTCb5YD7qpRkCXfR0g86Akw3ECrzGnObVlwFgOo-8ywgFEFSduPzx2ja0D3NCzfW7ZgqKtTgZDCgfCLWjXxWj7flh3vu3B_dqtQ5Mqmeum9LN0RBGdEz03zscS44CmJ"
/// program_count : 18

class User {
  User({
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
      this.programCount,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    profile = json['profile'];
    cover = json['cover'];
    address = json['address'];
    age = json['age'];
    about = json['about'];
    gender = json['gender'];
    levelId = json['level_id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    language = json['language'];
    invitationBy = json['invitation_by'];
    month = json['month'];
    emailVerifiedAt = json['email_verified_at'];
    numOfRating = json['num_of_rating'];
    rateAvg = json['rate_avg'];
    isFollow = json['is_follow'];
    fcmToken = json['fcm_token'];
    programCount = json['program_count'];
  }
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
  String? month;
  dynamic emailVerifiedAt;
  int? numOfRating;
  String? rateAvg;
  bool? isFollow;
  String? fcmToken;
  int? programCount;
User copyWith({  int? id,
  String? name,
  String? mobile,
  String? email,
  String? profile,
  String? cover,
  dynamic address,
  dynamic age,
  String? about,
  String? gender,
  int? levelId,
  int? countryId,
  int? cityId,
  String? language,
  dynamic invitationBy,
  String? month,
  dynamic emailVerifiedAt,
  int? numOfRating,
  String? rateAvg,
  bool? isFollow,
  String? fcmToken,
  int? programCount,
}) => User(  id: id ?? this.id,
  name: name ?? this.name,
  mobile: mobile ?? this.mobile,
  email: email ?? this.email,
  profile: profile ?? this.profile,
  cover: cover ?? this.cover,
  address: address ?? this.address,
  age: age ?? this.age,
  about: about ?? this.about,
  gender: gender ?? this.gender,
  levelId: levelId ?? this.levelId,
  countryId: countryId ?? this.countryId,
  cityId: cityId ?? this.cityId,
  language: language ?? this.language,
  invitationBy: invitationBy ?? this.invitationBy,
  month: month ?? this.month,
  emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
  numOfRating: numOfRating ?? this.numOfRating,
  rateAvg: rateAvg ?? this.rateAvg,
  isFollow: isFollow ?? this.isFollow,
  fcmToken: fcmToken ?? this.fcmToken,
  programCount: programCount ?? this.programCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['profile'] = profile;
    map['cover'] = cover;
    map['address'] = address;
    map['age'] = age;
    map['about'] = about;
    map['gender'] = gender;
    map['level_id'] = levelId;
    map['country_id'] = countryId;
    map['city_id'] = cityId;
    map['language'] = language;
    map['invitation_by'] = invitationBy;
    map['month'] = month;
    map['email_verified_at'] = emailVerifiedAt;
    map['num_of_rating'] = numOfRating;
    map['rate_avg'] = rateAvg;
    map['is_follow'] = isFollow;
    map['fcm_token'] = fcmToken;
    map['program_count'] = programCount;
    return map;
  }

}

/// current_page : 1
/// maincommentData : [{"id":190,"user_id":11720,"comment":"user","live_id":308,"updated_at":"2023-12-07 09:01:46","time_ago":"5 minutes ago"}]
/// first_page_url : "https://creen-program.com/api/live/show?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://creen-program.com/api/live/show?page=1"
/// next_page_url : null
/// path : "https://creen-program.com/api/live/show"
/// per_page : 5
/// prev_page_url : null
/// to : 1
/// total : 1

class Maincomments {
  Maincomments({
      this.currentPage,
      this.maincommentData,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,});

  Maincomments.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      maincommentData = [];
      json['data'].forEach((v) {
        maincommentData?.add(MaincommentData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
  int? currentPage;
  List<MaincommentData>? maincommentData;
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
Maincomments copyWith({  int? currentPage,
  List<MaincommentData>? maincommentData,
  String? firstPageUrl,
  int? from,
  int? lastPage,
  String? lastPageUrl,
  dynamic nextPageUrl,
  String? path,
  int? perPage,
  dynamic prevPageUrl,
  int? to,
  int? total,
}) => Maincomments(  currentPage: currentPage ?? this.currentPage,
  maincommentData: maincommentData ?? this.maincommentData,
  firstPageUrl: firstPageUrl ?? this.firstPageUrl,
  from: from ?? this.from,
  lastPage: lastPage ?? this.lastPage,
  lastPageUrl: lastPageUrl ?? this.lastPageUrl,
  nextPageUrl: nextPageUrl ?? this.nextPageUrl,
  path: path ?? this.path,
  perPage: perPage ?? this.perPage,
  prevPageUrl: prevPageUrl ?? this.prevPageUrl,
  to: to ?? this.to,
  total: total ?? this.total,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    if (maincommentData != null) {
      map['data'] = maincommentData?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = firstPageUrl;
    map['from'] = from;
    map['last_page'] = lastPage;
    map['last_page_url'] = lastPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['path'] = path;
    map['per_page'] = perPage;
    map['prev_page_url'] = prevPageUrl;
    map['to'] = to;
    map['total'] = total;
    return map;
  }

}

/// id : 190
/// user_id : 11720
/// comment : "user"
/// live_id : 308
/// updated_at : "2023-12-07 09:01:46"
/// time_ago : "5 minutes ago"

/*class MaincommentData {
  MaincommentData({
      this.id,
      this.userId,
      this.comment,
      this.liveId,
      this.updatedAt,
      this.timeAgo,});*/
