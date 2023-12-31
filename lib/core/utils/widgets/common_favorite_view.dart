import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

class CommonFavoriteView extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool isSelected;
  final double radius, padding;
  const CommonFavoriteView(
      {Key? key,
      required this.onTap,
      required this.icon,
      required this.isSelected,
      this.radius = 26,
      this.padding = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isSelected ? Colors.red : MainStyle.mainGray,
      ),
    );
  }
}
