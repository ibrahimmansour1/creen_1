import 'dart:developer';

import 'package:flutter/material.dart';

class IconItem extends StatefulWidget {
   IconItem(
      {super.key,
      required this.onIcon,
      required this.offIcon,
      required this.onTap,
      required this.offTap,
       this.on = true,});

  final IconData onIcon;
  final IconData offIcon;
  final Function() onTap;
  final Function() offTap;
  bool on;
  @override
  State<IconItem> createState() => _IconItemState();
}

class _IconItemState extends State<IconItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await widget.onTap().then((value) {
          setState(() {
            widget.on = !widget.on;
          });
          widget.on ? widget.onTap() : widget.offTap();
          log("on : ${widget.on}");
        }).catchError((e) {
          log("Icon Error : ${e.toString()}");
          log("on : ${widget.on}");
        });
      },
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.on ? widget.offIcon : widget.onIcon,
            size: 33,
            color: Colors.white,
          )),
    );
  }
}
