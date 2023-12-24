class StoryData {
  StoryData({
    this.id,
    this.userId,
    this.description,
    this.image,
    this.record,
    this.status,
    this.seen,
    this.video,
    this.deletedAt,
    this.timeAgo,
    this.background,
    this.fontSize,
    this.fontFamily,
    this.fontColor,
    this.align,
    this.fontWeight,
    this.outline,
    this.fontBorderColor,
  });

  int? id;
  int? userId;
  dynamic description;
  dynamic image;
  dynamic record;
  int? status;
  int? seen;
  dynamic video;
  dynamic deletedAt;
  String? timeAgo;
  String? background;
  String? fontSize;
  String? fontFamily;
  String? fontColor;
  String? align;
  String? fontWeight;
  String? outline;
  String? fontBorderColor;

  factory StoryData.fromJson(Map<String, dynamic> json) => StoryData(
        id: json["id"],
        userId: json["user_id"],
        description: json["description"],
        image: json["image"],
        record: json["record"],
        status: json["status"],
        seen: json["seen"],
        video: json["video"],
        deletedAt: json["deleted_at"],
        timeAgo: json["time_ago"],
        background: json["background"],
        fontSize: json["style"]["font_size"],
        fontFamily: json["style"]["font_family"],
        fontColor: json["style"]["font_color"],
        align: json["style"]["align"],
        fontWeight: json["style"]["font_weight"],
        outline: json["style"]["outline"],
        fontBorderColor: json["style"]["font_border_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "description": description,
        "image": image,
        "record": record,
        "status": status,
        "seen": seen,
        "video": video,
        "deleted_at": deletedAt,
        "time_ago": timeAgo,
        "background": background,
        "fontSize": fontSize,
        "fontFamily": fontFamily,
        "fontColor": fontColor,
        "align": align,
        "fontWeight": fontWeight,
        "outline": outline,
        "font_border_color": fontBorderColor,
      };
}
