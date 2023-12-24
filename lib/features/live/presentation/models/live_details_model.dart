class LiveDetailsModel {
  int? id;
  String name;
  String profile;
  String cover;

  LiveDetailsModel({
    this.id,
    required this.name,
    required this.profile,
    required this.cover,
  });
}

class LiveComments {
  int? id;
  int? userId;
  String name;
  String? profile;
  String comment;

  LiveComments({
    this.id,
    this.userId,
    required this.name,
    required this.profile,
    required this.comment,
  });
}
