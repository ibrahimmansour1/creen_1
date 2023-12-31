import 'package:flutter/material.dart' hide NavigationDrawer;
import 'dart:math' as math;

class MirrorWidget extends StatelessWidget {
  const MirrorWidget({
    Key? key,
    required this.child,
    this.mirror = true,
  }) : super(key: key);
  final Widget child;
  final bool mirror;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(mirror ? math.pi : 0),
      child: child,
    );
  }
}
