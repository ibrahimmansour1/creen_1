import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class AccountCardInfo extends StatelessWidget {
  const AccountCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: BoxDecoration(
          color: const Color(0x1a00cc93),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: const Color(0xff00CC93),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                        AssetImage('assets/images/fayez.png'),
                        radius: 29,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "أحمد فايز",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontFamily: "Bahij_TheSansArabic",
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                                "assets/images/wallet-money.svg"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "رصيدك 5000 جنية",
                              style: TextStyle(
                                color:
                                Colors.white.withOpacity(.8),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Bahij_TheSansArabic",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffFFF5DD),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/crown.svg"),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("20,000 نقطة",style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: "Bahij_TheSansArabic",
                          fontSize: 12,
                        ),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 18.0, vertical: 12),
            child: Row(
              children: [
                const Text(
                  "تقييمك",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 5,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    itemSize: 25,
                    glow: false,
                    unratedColor: Color(0xffD1D0CC),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => SvgPicture.asset(
                      "assets/images/star.svg",
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
              ],
            ),
          ),
           const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                height: 3,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(20)),
                  child: LinearProgressIndicator(
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
