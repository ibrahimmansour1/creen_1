import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrainerDescription extends StatelessWidget {
  const TrainerDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .10,
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
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        "احمد فايز",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .018,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "مدرب لياقة",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .016,
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
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        "معنى الوصف في قاموس معاجم اللغة. لسان العرب. وصف وصَف الشيءَ له وعليه وصْفاً وصِفةً حَلاَّه والهاء عوض من الواو وقيل الوصْف معنى الوصف في قاموس معاجم اللغة. لسان العرب. وصف وصَف الشيءَ له وعليه وصْفاً وصِفةً حَلاَّه والهاء عوض من الواو وقيل الوصْف معنى الوصف في قاموس معاجم اللغة. لسان العرب. وصف وصَف الشيءَ له وعليه وصْفاً وصِفةً حَلاَّه والهاء عوض من الواو وقيل الوصْف معنى الوصف في قاموس معاجم اللغة. لسان العرب. وصف وصَف الشيءَ له وعليه وصْفاً وصِفةً حَلاَّه والهاء عوض من الواو وقيل الوصْف معنى الوصف في قاموس معاجم اللغة. لسان العرب. وصف وصَف الشيءَ له وعليه وصْفاً وصِفةً حَلاَّه والهاء عوض من الواو وقيل الوصْف معنى الوصف في قاموس معاجم اللغة. لسان العرب. وصف وصَف الشيءَ له وعليه وصْفاً وصِفةً حَلاَّه والهاء عوض من الواو وقيل الوصْف معنى الوصف في قاموس معاجم اللغة. لسان العرب. وصف وصَف الشيءَ له وعليه وصْفاً وصِفةً حَلاَّه والهاء عوض من الواو وقيل الوصْف معنى الوصف في قاموس معاجم اللغة. لسان العرب.",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*.022,
                    ),),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff0e2b33),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "اشتراك",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
