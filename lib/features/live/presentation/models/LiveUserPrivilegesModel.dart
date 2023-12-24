/// status : true
/// message : "app.lives"
/// data : {"id":80,"live_id":110,"user_id":11720,"name":null,"mic":0,"camera":0,"sound":0,"priveleges":"creator","updated_at":"2023-11-01 20:47:39","comment":0,"gift":0,"userpublic":0,"chat":0,"remote_id":null,"time_ago":"3 weeks ago"}

class LiveUserPrivilegesModel {
  LiveUserPrivilegesModel({
      this.status, 
      this.message, 
      this.data,});

  LiveUserPrivilegesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;
LiveUserPrivilegesModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => LiveUserPrivilegesModel(  status: status ?? this.status,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : 80
/// live_id : 110
/// user_id : 11720
/// name : null
/// mic : 0
/// camera : 0
/// sound : 0
/// priveleges : "creator"
/// updated_at : "2023-11-01 20:47:39"
/// comment : 0
/// gift : 0
/// userpublic : 0
/// chat : 0
/// remote_id : null
/// time_ago : "3 weeks ago"

class Data {
  Data({
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
      this.timeAgo,});

  Data.fromJson(dynamic json) {
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
Data copyWith({  int? id,
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
}) => Data(  id: id ?? this.id,
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
    return map;
  }

}