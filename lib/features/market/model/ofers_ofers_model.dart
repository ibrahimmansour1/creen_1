class OffersOffersModel{
  int? id;
  String name;
  List<String> image;
  String category;
  String content;
  double oldPrice;
  double currentPrice;
  double rate;
  List<int> colors;
  List<int> colorShown;

  OffersOffersModel({
    required this.name,
    required this.image,
    required this.category,
    required this.content,
    required this.oldPrice,
    required this.currentPrice,
    required this.rate,
    required this.colors,
    required this.colorShown,
  });
}