class LiveStickerModel {
  int? id;
  String userName;
  String? userProfile;
  String sticker;
  String stickerKind;
  int number;

  LiveStickerModel({
     this.id,
    required this.userName,
    required this.userProfile,
    required this.sticker,
    required this.stickerKind,
    required this.number,
  });
}
