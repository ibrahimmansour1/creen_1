/// id : 190
/// user_id : 11720
/// comment : "user"
/// live_id : 308
/// updated_at : "2023-12-07 09:01:46"
/// time_ago : "5 minutes ago"

class MaincommentData {
  MaincommentData({
      this.id, 
      this.userId, 
      this.comment, 
      this.liveId, 
      this.updatedAt, 
      this.timeAgo,});

  MaincommentData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    comment = json['comment'];
    liveId = json['live_id'];
    updatedAt = json['updated_at'];
    timeAgo = json['time_ago'];
  }
  int? id;
  int? userId;
  String? comment;
  int? liveId;
  String? updatedAt;
  String? timeAgo;
MaincommentData copyWith({  int? id,
  int? userId,
  String? comment,
  int? liveId,
  String? updatedAt,
  String? timeAgo,
}) => MaincommentData(  id: id ?? this.id,
  userId: userId ?? this.userId,
  comment: comment ?? this.comment,
  liveId: liveId ?? this.liveId,
  updatedAt: updatedAt ?? this.updatedAt,
  timeAgo: timeAgo ?? this.timeAgo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['comment'] = comment;
    map['live_id'] = liveId;
    map['updated_at'] = updatedAt;
    map['time_ago'] = timeAgo;
    return map;
  }

}