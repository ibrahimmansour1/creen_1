import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget ({super.key, required this.title, required this.tabTap, required this.active});
final String title;
final bool active;
final void Function()? tabTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: tabTap,
        child: Container(
          // width: MediaQuery.sizeOf(context).width*0.9/3,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Colors.transparent,
            color: active?Colors.grey.shade300.withOpacity(0.3):Colors.transparent,
            border: Border.all(color: Colors.black),
          ),
          child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.white),),
        ),
      ),
    );

  }
}
