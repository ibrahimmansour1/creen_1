import 'package:flutter/material.dart';

class LiveTextButton extends StatelessWidget {
  const LiveTextButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.active,
  });

  final String text;
  final void Function()? onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20), left: Radius.circular(20)),
      child: Container(
        height: 30,
        width: 140,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20), left: Radius.circular(20)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active?Colors.black:Colors.grey,
          ),
        ),
      ),
    );
  }
}
