/// status : true
/// message : "app.lives"
/// data : {"live_id":"104","user_id":11720,"name":null,"priveleges":"admin","remote_id":"null","updated_at":"2023-11-24 16:49:31","id":237,"time_ago":"1 second ago"}

class LiveUserJoinModel {
  LiveUserJoinModel({
      this.status, 
      this.message, 
      this.data,});

  LiveUserJoinModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  Data? data;
LiveUserJoinModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => LiveUserJoinModel(  status: status ?? this.status,
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

/// live_id : "104"
/// user_id : 11720
/// name : null
/// priveleges : "admin"
/// remote_id : "null"
/// updated_at : "2023-11-24 16:49:31"
/// id : 237
/// time_ago : "1 second ago"

class Data {
  Data({
      this.liveId, 
      this.userId, 
      this.name, 
      this.priveleges, 
      this.remoteId, 
      this.updatedAt, 
      this.id, 
      this.timeAgo,});

  Data.fromJson(dynamic json) {
    liveId = json['live_id'];
    userId = json['user_id'];
    name = json['name'];
    priveleges = json['priveleges'];
    remoteId = json['remote_id'];
    updatedAt = json['updated_at'];
    id = json['id'];
    timeAgo = json['time_ago'];
  }
  String? liveId;
  int? userId;
  dynamic name;
  String? priveleges;
  String? remoteId;
  String? updatedAt;
  int? id;
  String? timeAgo;
Data copyWith({  String? liveId,
  int? userId,
  dynamic name,
  String? priveleges,
  String? remoteId,
  String? updatedAt,
  int? id,
  String? timeAgo,
}) => Data(  liveId: liveId ?? this.liveId,
  userId: userId ?? this.userId,
  name: name ?? this.name,
  priveleges: priveleges ?? this.priveleges,
  remoteId: remoteId ?? this.remoteId,
  updatedAt: updatedAt ?? this.updatedAt,
  id: id ?? this.id,
  timeAgo: timeAgo ?? this.timeAgo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['live_id'] = liveId;
    map['user_id'] = userId;
    map['name'] = name;
    map['priveleges'] = priveleges;
    map['remote_id'] = remoteId;
    map['updated_at'] = updatedAt;
    map['id'] = id;
    map['time_ago'] = timeAgo;
    return map;
  }

}