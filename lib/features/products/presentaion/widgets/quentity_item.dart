import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final valueProvider = StateProvider((ref) => 0);

class QuentityItem extends StatelessWidget {
  final String text;
  final int qty;
  final void Function() onIncrement;
  final void Function() onDecrement;

  const QuentityItem({
    Key? key,
    required this.text,
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int value = ref.watch(valueProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onIncrement,
                child: Container(
                  width: Sizes.screenWidth() * 0.2,
                  height: Sizes.screenHeight() * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: MainStyle.primaryColor),
                      color: MainStyle.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                  alignment: Alignment.center,
                  width: Sizes.screenWidth() * 0.45,
                  height: Sizes.screenHeight() * 0.08,
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  //margin: const EdgeInsets.fromLTRB(10, 10, 10, 18),
                  decoration: BoxDecoration(
                      border: Border.all(color: MainStyle.navigationColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      qty.toString(),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: onDecrement,
                child: Container(
                  width: Sizes.screenWidth() * 0.2,
                  height: Sizes.screenHeight() * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: MainStyle.primaryColor),
                      color: MainStyle.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
