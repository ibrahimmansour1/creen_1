class LiveItemModel {
  int? id;
  String name;
  String? content;
  String? userProfile;
  String? liveSnapshot;

  LiveItemModel({
     this.id,
    required this.name,
    required this.content,
    required this.userProfile,
    required this.liveSnapshot,
  });
}
