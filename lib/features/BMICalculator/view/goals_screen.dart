import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/elusive_icons.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  int steps = 1000;
  int time = 30;
  double calories = 300;
  double distance = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'goals'.translate,
          style: MainTheme.appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'goals'.translate,
                    style: MainTheme.appBarTextStyle,
                  ),
                  const BoxHelper(
                    height: 10,
                  ),
                  Text(
                    'determine_target'.translate,
                    style: MainTheme.appBarTextStyle
                        .copyWith(color: Colors.white60),
                  ),
                ],
              ),
            ),
            GoalItem(
              title: "$steps",
              onDecrement: () {
                setState(() {
                  steps -=1;
                });
              },
              onIncrement: () {
                setState(() {
                  steps +=1;
                });
              },
              subtitleItems:  [
                Text(
                  'the_steps'.translate,
                  style: const TextStyle(color: Colors.white),
                ),
                const BoxHelper(
                  width: 3,
                ),
                const Icon(
                  Icons.run_circle,
                  color: Colors.white,
                )
              ].reversed.toList(),
            ),
            const BoxHelper(
              height: 30,
            ),
            GoalItem(
              title: "$calories",
              onDecrement: () {
                setState(() {
                  calories -=1;
                });
              },
              onIncrement: () {
                setState(() {
                  calories +=1;
                });
              },
              subtitleItems:  [
                Text(
                  'kilo_calory'.translate,
                  style: const TextStyle(color: Colors.white),
                ),
                const BoxHelper(
                  width: 3,
                ),
                const Icon(
                  Elusive.fire,
                  color: Colors.white,
                )
              ].reversed.toList(),
            ),
            GoalItem(
              title: "$distance",
              onDecrement: () {
                setState(() {
                  distance -=0.5;
                });
              },
              onIncrement: () {
                setState(() {
                  distance +=0.5;
                });
              },
              subtitleItems:  [
                Text(
                  'km'.translate,
                  style: const TextStyle(color: Colors.white),
                ),
                const BoxHelper(
                  width: 3,
                ),
                const Icon(
                  Elusive.fire,
                  color: Colors.white,
                )
              ].reversed.toList(),
            ),
            GoalItem(
              title: '$time',
              onDecrement: () {
                setState(() {
                  time -=1;
                });
              },
              onIncrement: () {
                setState(() {
                  time +=1;
                });
              },
              subtitleItems:  [
                Text(
                  'm'.translate,
                  style: const TextStyle(color: Colors.white),
                ),
                const BoxHelper(
                  width: 3,
                ),
                const Icon(
                  Elusive.fire,
                  color: Colors.white,
                )
              ].reversed.toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalItem extends StatelessWidget {
  const GoalItem({
    super.key,
    required this.title,
    required this.subtitleItems,
    required this.onIncrement,
    required this.onDecrement,
  });
  final String title;
  final List<Widget> subtitleItems;
  final void Function() onIncrement;
  final void Function() onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.r,
        vertical: 10.r,
      ),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(
          5.r,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.r,
        vertical: 15.r,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onDecrement,
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const BoxHelper(
                height: 10,
              ),
              Row(
                children: subtitleItems,
              ),
            ],
          ),
          InkWell(
            onTap: onIncrement,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
