class StepData {
  int? id;
  int? userId;
  int? currentSteps;
  int? goal;
  double? calaroies;
  String? houres;
  String? minutes;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? timeAgo;

  StepData({
    this.id,
    this.userId,
    this.currentSteps,
    this.goal,
    this.calaroies,
    this.houres,
    this.minutes,
    this.createdAt,
    this.updatedAt,
    this.timeAgo,
  });

  factory StepData.fromJson(Map<String, dynamic> json) => StepData(
        id: int.tryParse(json["id"]?.toString() ?? ''),
        userId: int.tryParse(json["user_id"]?.toString() ?? ''),
        currentSteps: int.tryParse(json["currentSteps"]?.toString() ?? ''),
        goal: int.tryParse(json["goal"]?.toString() ?? ''),
        calaroies: double.tryParse(json["calaroies"]?.toString() ?? ''),
        houres: json["houres"]?.toString(),
        minutes: json["minutes"]?.toString(),
        createdAt: DateTime.tryParse(json["created_at"] ?? ''),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ''),
        timeAgo: json["time_ago"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "currentSteps": currentSteps,
        "goal": goal,
        "calaroies": calaroies,
        "houres": houres,
        "minutes": minutes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "time_ago": timeAgo,
      };
}
