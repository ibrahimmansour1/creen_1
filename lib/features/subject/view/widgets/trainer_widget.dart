import 'package:creen/core/utils/extensions/num_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class TrainerWidget extends StatelessWidget {
  const TrainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .36,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "أختر مدربك وانطلق نحو الهدف",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height * .022,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    index == 0
                        ? const SizedBox(
                            width: 10,
                          )
                        : const SizedBox(),
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: MediaQuery.of(context).size.height * .1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                      child: Image.asset(
                                        "assets/images/bg.png",
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .10,
                                width: MediaQuery.of(context).size.height * .10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * .10,
                                  ),
                                  color: const Color(0xffF2F2F2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * .10,
                                  ),
                                  child: Image.asset(
                                    "assets/images/man.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "احمد فايز",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .018,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "مدرب لياقة",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .016,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              RatingBarIndicator(
                                rating: 2.75,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15.0,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.blue)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 5.0),
                                        child: Text("شاهد"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
