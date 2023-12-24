class OffersCartModel{
  int? id;
  String name;
  String image;
  double currentPrice;
  double lastPrice;

  OffersCartModel({
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.lastPrice,
  });
}