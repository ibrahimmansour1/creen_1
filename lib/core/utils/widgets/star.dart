import 'package:flutter/material.dart';

class StarIcon extends StatelessWidget {
  const StarIcon({super.key,  this.size = 60});
final double size;
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/star.png', width: size, height: size);
  }
}
