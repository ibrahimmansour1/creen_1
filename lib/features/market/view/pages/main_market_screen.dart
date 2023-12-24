import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/market/model/offers_cart_model.dart';
import 'package:flutter/material.dart';

import '../../model/category_cart_model.dart';
import '../../model/ofers_ofers_model.dart';

class MainMarketScreen extends StatefulWidget {
  static const String imageTest =
      "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403";
  static const String assetBasePath = "assets/images/";
  static const String imageTest2 = "test_image.jpg";

  MainMarketScreen({super.key});

  @override
  State<MainMarketScreen> createState() => _MainMarketScreenState();
}

class _MainMarketScreenState extends State<MainMarketScreen> {
  TextEditingController searchController = TextEditingController();

  int topAddListLength = 2;

  int middleAddListLength = 2;

  int bottomAddListLength = 2;

  List<String> middleAdsAssets = [
    "${MainMarketScreen.assetBasePath}cart_image.jpg",
    "${MainMarketScreen.assetBasePath}cart_image2.jpg",
  ];

  List<String> bottomAdsAssets = [
    "${MainMarketScreen.assetBasePath}bottom_cart.jpg",
    "${MainMarketScreen.assetBasePath}bottom_cart2.jpg",
    "${MainMarketScreen.assetBasePath}bottom_cart3.jpg",
    "${MainMarketScreen.assetBasePath}bottom_cart4.jpg",
  ];
  List<String> mostWantedAssets = [
    "${MainMarketScreen.assetBasePath}cart_image4.jpg",
    "${MainMarketScreen.assetBasePath}cart_image5.jpg",
    "${MainMarketScreen.assetBasePath}cart_image6.jpg",
  ];
  List<String> mostWantedText = [
    "الأكثر مبيعاً",
    "الأكثر تفاعلاً",
    "الأكثر مشاهده",
  ];

  List<CategoryCartModel> categoriesCart = [
    CategoryCartModel(
        name: "ملابس الأولاد",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجات جديدة"),
    CategoryCartModel(
        name: "ملابس ",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجات جديدة"),
    CategoryCartModel(
        name: "ملابس الأولاد",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجات "),
    CategoryCartModel(
        name: "ملابس بناتي",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجات جديدة"),
    CategoryCartModel(
        name: "ملابس يسبسبؤسبيالأولاد",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجات جديدة"),
    CategoryCartModel(
        name: "ملابس الأولاد",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجاتيسلبسيلققلر جديدة"),
    CategoryCartModel(
        name: "ملابس الأولاد",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجقاثقاقثاثقات جديدة"),
    CategoryCartModel(
        name: "ملابس الأولاد",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجاثقافثات جديدة"),
    CategoryCartModel(
        name: "ملابس الأولاد",
        image: "${MainMarketScreen.assetBasePath}cart_image2.jpg",
        content: "منتجاثقافثات جديدة"),
  ];

  List<OffersCartModel> offersCart = [
    OffersCartModel(
        name: "ساعه",
        image: "https://m.media-amazon.com/images/I/61kTgdHQXZL._AC_SX679_.jpg",
        currentPrice: 80,
        lastPrice: 100),
    OffersCartModel(
        name: "ساعه",
        image:
            "https://m.media-amazon.com/images/I/71Bk3SsBABL.__AC_SX300_SY300_QL70_ML2_.jpg",
        currentPrice: 80,
        lastPrice: 100),
    OffersCartModel(
        name: "ساعه",
        image:
            "https://m.media-amazon.com/images/I/61B+ITLXNXL._AC_SY300_SX300_.jpg",
        currentPrice: 80,
        lastPrice: 100),
    OffersCartModel(
        name: "ساعه",
        image:
            "https://cdn.salla.sa/YFPfzzPUOl9cTjtThHDUncanqbqS4KbXrDpv3Cyi.png",
        currentPrice: 80,
        lastPrice: 100),
  ];

  List<OffersOffersModel> offersOffers = [
    OffersOffersModel(
        name: 'ماسك وجه ساده',
        image: [
          'https://m.media-amazon.com/images/I/61kTgdHQXZL._AC_SX679_.jpg'
              'https://m.media-amazon.com/images/I/61kTgdHQXZL._AC_SX679_.jpg'
        ],
        category: 'تخفيضات الموضه',
        content: 'للحمايه من الاشعه فوق البنفسجيه',
        oldPrice: 10.0,
        currentPrice: 6.82,
        rate: 4.4,
        colors: [
          0xffc7106f,
          0xff12dd74,
          0xffdd9d12,
          0xff12ccdd,
          0xff7bdd12,
        ],
        colorShown: [0, 0]),
    OffersOffersModel(
        name: 'ماسك وجه ساده',
        image: [
          'https://m.media-amazon.com/images/I/71Bk3SsBABL.__AC_SX300_SY300_QL70_ML2_.jpg'
              'https://m.media-amazon.com/images/I/61kTgdHQXZL._AC_SX679_.jpg'
        ],
        category: 'تخفيضات الموضه',
        content: 'للحمايه من الاشعه فوق البنفسجيه',
        oldPrice: 10.0,
        currentPrice: 6.82,
        rate: 4.4,
        colors: [
          0xffc7106f,
          0xff12dd74,
          0xffdd9d12,
          0xff12ccdd,
          0xff7bdd12,
        ],
        colorShown: [0, 0]),
    OffersOffersModel(
        name: 'ماسك وجه ساده',
        image: [
          'https://m.media-amazon.com/images/I/61B+ITLXNXL._AC_SY300_SX300_.jpg'
              'https://m.media-amazon.com/images/I/61kTgdHQXZL._AC_SX679_.jpg'
        ],
        category: 'تخفيضات الموضه',
        content: 'للحمايه من الاشعه فوق البنفسجيه',
        oldPrice: 10.0,
        currentPrice: 6.82,
        rate: 4.4,
        colors: [
          0xffc7106f,
          0xff12dd74,
          0xffdd9d12,
          0xff12ccdd,
          0xff7bdd12,
        ],
        colorShown: [0, 0]),
    OffersOffersModel(
        name: 'ماسك وجه ساده',
        image: [
          "https://cdn.salla.sa/YFPfzzPUOl9cTjtThHDUncanqbqS4KbXrDpv3Cyi.png",
          'https://m.media-amazon.com/images/I/61kTgdHQXZL._AC_SX679_.jpg'
        ],
        category: 'تخفيضات الموضه',
        content: 'للحمايه من الاشعه فوق البنفسجيه',
        oldPrice: 10.0,
        currentPrice: 6.82,
        rate: 4.4,
        colors: [
          0xffc7106f,
          0xff12dd74,
          0xffdd9d12,
          0xff12ccdd,
          0xff7bdd12,
        ],
        colorShown: [0, 0]),
  ];

  int shown = 0;

  var proKey = GlobalKey(debugLabel: 'product');
   ScrollController scroll = ScrollController();
   double  ribbonHeight = 0.0;
   int previousIndex = 0;
   List<TabModel>tabs = [
     TabModel(name: 'categories',selected: true),
     TabModel(name: 'latest_products'),
     TabModel(name: 'special_products'),
     TabModel(name: 'my_likes'),
     TabModel(name: 'offers'),
   ];
  @override
  void initState() {
scroll.addListener(() {
if((proKey.currentContext?.mounted??false)&&scroll.position.userScrollDirection.name == 'reverse') {
  setState(() {
    ribbonHeight++;
  });
} else if((proKey.currentContext?.mounted??false)&&scroll.position.userScrollDirection.name == 'forward') {
    setState(() {
  ribbonHeight--;
  if(ribbonHeight <0) {
    ribbonHeight =0.0;
  }
});

  }
else if(!(proKey.currentContext?.mounted??false)){
  setState(() {
    ribbonHeight =0.0;
  });
}

  log('ribbon height $ribbonHeight');
  log('pro key ==? ${proKey.currentContext?.mounted}');
  // log('scroll ==? ${scroll.position.userScrollDirection.name/*-initialOffset*/}');

});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
/*setState(() {
  log('scroll ==? ${proKey.currentContext?.debugDoingBuild}');

});*/
    /*if (proKey.currentContext?.debugDoingBuild ?? false) {
      log('success',name: 'pro view');
    } else {
      log('failed',name: 'pro view');
    }*/
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          width: size.width * 0.7,
          // height: size.height * 0.04,
          constraints: BoxConstraints(maxHeight: size.height * 0.048),
          child: TextFormField(
            controller: searchController,
            keyboardType: TextInputType.text,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: "ادخل كلمه",
              filled: true,
              fillColor: Colors.grey.withOpacity(0.4),
              prefixIcon: InkWell(
                onTap: () {},
                child: const Icon(Icons.search),
              ),
              suffixIcon: const Text(
                "بحث",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 19,
                ),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
            ),
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.menu,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ListView(
            controller: scroll,
            padding: const EdgeInsets.only(bottom: 10),
            children: [
              Container(
                width: size.width,
                height: size.height * 0.2,
                margin: const EdgeInsets.only(bottom: 2),
                color: const Color(0xfffdd4ce),
                // color: Colors.amberAccent[100],
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Container(
                    width: (size.width / topAddListLength) - 10 - 2,

                    alignment: Alignment.center,
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    height: size.height * 0.2,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(MainMarketScreen.assetBasePath +
                          MainMarketScreen.imageTest2),
                      // image: NetworkImage(imageTest),
                      fit: BoxFit.contain,
                    )),
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    /* return Container(
                      height: 10,
                      width: 2.0,
                      constraints: BoxConstraints(maxHeight: 5),
                      color: Colors.grey,
                    );*/
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 50),
                      height: 50,
                      width: 2.0,
                      constraints:
                          const BoxConstraints(maxHeight: 50, maxWidth: 2.0),
                      color: Colors.grey,
                    );
                  },
                  itemCount: topAddListLength,
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.2,
                margin: const EdgeInsets.only(bottom: 2),

                color: const Color(0xffffbec2),
                // color: Colors.amberAccent[100],
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                      height: size.height * 0.2,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      scrollDirection: Axis.horizontal),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return Container(
                      width: size.width,

                      alignment: Alignment.center,
                      // padding: EdgeInsets.symmetric(vertical: 10),
                      // margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(middleAdsAssets[index]),
                        // image: NetworkImage(imageTest),
                        fit: BoxFit.cover,
                      )),
                    );
                  },
                  itemCount: middleAdsAssets.length,
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.2,
                margin: const EdgeInsets.only(bottom: 2),
                color: const Color(0xfffce2e1),
                // color: Colors.amberAccent[100],
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Container(
                    width: (size.width / bottomAdsAssets.length),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(bottomAdsAssets[index]),

                      // image: NetworkImage(imageTest),
                      // scale: 4.0,
                      fit: BoxFit.fill,
                    )),
                  ),
                  itemCount: bottomAdsAssets.length,
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.26,
                margin: const EdgeInsets.only(bottom: 2),
                color: const Color(0xfffcc5e2),
                // color: Colors.amberAccent[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "تسوق حسب الفئات",
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.21,
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                          height: size.height * 0.18,
                          viewportFraction: 0.5,
                          autoPlay: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          if (categoriesCart.length % 2 == 1 &&
                              index == ((categoriesCart.length / 2).ceil()) - 1) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: size.width * 0.45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),

                                  alignment: Alignment.center,
                                  // padding: EdgeInsets.symmetric(vertical: 10),
                                  // margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                  height: 60,

                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(30),
                                      left: Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade300,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  categoriesCart[2 * index].image),
                                              fit: BoxFit.contain,
                                            )),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.28,
                                        height: 60,
                                        child: Column(
                                          children: [
                                            Text(
                                              categoriesCart[2 * index].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              categoriesCart[2 * index].content,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: Colors.pinkAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: size.width * 0.45,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),

                                  alignment: Alignment.center,
                                  // padding: EdgeInsets.symmetric(vertical: 10),
                                  // margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                  height: 60,

                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(30),
                                      left: Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade300,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  categoriesCart[index * 2].image),
                                              fit: BoxFit.contain,
                                            )),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.28,
                                        height: 60,
                                        child: Column(
                                          children: [
                                            Text(
                                              categoriesCart[index * 2].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              categoriesCart[index * 2].content,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: Colors.pinkAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.45,

                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),

                                  alignment: Alignment.center,
                                  // padding: EdgeInsets.symmetric(vertical: 10),
                                  // margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                  height: 60,

                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(30),
                                      left: Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade300,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  categoriesCart[index * 2 + 1]
                                                      .image),
                                              fit: BoxFit.contain,
                                            )),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.28,
                                        height: 55,
                                        child: Column(
                                          children: [
                                            Text(
                                              categoriesCart[index * 2 + 1].name,
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              categoriesCart[index].content,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: Colors.pinkAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                        itemCount: (categoriesCart.length / 2).ceil(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.36,
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.amberAccent.shade100,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
                // color: const Color(0xfffce2e1),
                // color: Colors.amberAccent[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text("عروض و خصومات"),
                            Icon(
                              Icons.local_offer_outlined,
                              color: Colors.amber,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "00",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Text(
                                ":",
                                style: TextStyle(color: Colors.black),
                              ),
                              Container(
                                width: 25,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "19",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Text(
                                ":",
                                style: TextStyle(color: Colors.black),
                              ),
                              Container(
                                width: 25,
                                height: 28,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  "17",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.32,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => Container(
                          width: size.width * 0.3,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 5),
                          height: size.height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,

                            // image: NetworkImage(imageTest),
                            // scale: 4.0,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Image.network(
                                    offersCart[index].image,
                                    fit: BoxFit.cover,
                                    height: size.height * 0.22,
                                  ),
                                  Container(
                                    height: 20,
                                    width: size.width *
                                        0.3 *
                                        (offersCart[index].currentPrice /
                                            offersCart[index].lastPrice),
                                    color: Colors.red,
                                    child: Text(
                                      "${(offersCart[index].currentPrice / offersCart[index].lastPrice) * 100}%",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "${offersCart[index].currentPrice} SAR",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                "${offersCart[index].lastPrice} SAR",
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 20,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        itemCount: offersCart.length,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.2,
                margin: const EdgeInsets.only(bottom: 2),

                color: const Color(0xffe759a3),
                // color: Colors.amberAccent[100],
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: size.height * 0.2,
                    viewportFraction: 0.8,
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    return Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          width: size.width * 0.8,
                          margin: const EdgeInsets.symmetric(horizontal: 10),

                          alignment: Alignment.center,
                          // padding: EdgeInsets.symmetric(vertical: 10),
                          // margin: const EdgeI_nsets.symmetric(horizontal: 5,vertical: 10),
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(mostWantedAssets[index]),
                            // image: NetworkImage(imageTest),
                            fit: BoxFit.cover,
                          )),
                        ),
                        Container(
                          height: 30,
                          width: size.width * 0.2,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text(
                            mostWantedText[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: mostWantedAssets.length,
                ),
              ),
              Container(
                key: proKey,
                height: (350 * (offersOffers.length / 2).ceilToDouble()),
                width: size.width,
                color: Colors.grey.shade100,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 350),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              offersOffers[index].image[0],
                              fit: BoxFit.cover,
                              height: 180,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 25,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    offersOffers[index].category,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  offersOffers[index].name,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                width: 200,
                                child: Text(
                                  offersOffers[index].content,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Row(
                              children: [
                                Text(
                                  "${offersOffers[index].currentPrice}SAR",
                                  style: const TextStyle(
                                      color: Colors.pink,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${offersOffers[index].currentPrice}SAR",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                  size: 15,
                                ),
                                Text(
                                  offersOffers[index].rate.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 200,
                              height: 20,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, colorsIndex) {
                                  // log("index ${colorsIndex} show ${offersOffers[index].colorShown[shown]}");
                                  return Container(
                                    width: 20,
                                    height: 20,
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(
                                          offersOffers[index].colors[colorsIndex]),
                                      border:
                                          (offersOffers[index].colorShown[shown] ==
                                                  colorsIndex)
                                              ? Border.all(
                                                  color: Colors.black, width: 2.0)
                                              : null,
                                    ),
                                  );
                                },
                                itemCount: offersOffers[index].colors.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: offersOffers.length,
                ),
              ),
            ],
          ),
          Container(width: size.width,
          height: size.height*ribbonHeight,
          color: Colors.white,
          alignment: Alignment.center,
          constraints: BoxConstraints(minHeight: 0,maxHeight: size.height*0.05),
          child: ListView.builder(itemBuilder: (context,index) {
            Widget textWidget = Text(tabs[index].name.translate);
            return InkWell(onTap:(){
              setState(() {
                tabs[previousIndex].selected = false;
                tabs[index].selected =true;
                previousIndex = index;
              });
            },child: Container(
              margin:  EdgeInsets.symmetric(horizontal: size.width*0.025),

              decoration: BoxDecoration(
border:tabs[index].selected? const Border(bottom: BorderSide(color: Colors.black)):null,
              ),
              child: textWidget,
            ));
          },itemCount: tabs.length,
          scrollDirection: Axis.horizontal,),),
        ],
      ),
    );
  }
}

class TabModel{
  String name;
  bool selected;

  TabModel({required this.name,  this.selected=false,});

}