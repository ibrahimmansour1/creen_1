import 'dart:math';

import 'package:flutter/material.dart' hide NavigationDrawer;

class ResponsiveService {
  static const Size _designSize = Size(414, 895);
  static const bool _splitScreenMode = false;

  static late double textScaleFactor,
      devicePixelRatio,
      systemNavBarHeight,
      statusBarHeight,
      screenHeight,
      screenWidth;

  static double? defaultSize;
  static Orientation? orientation;
  static late MediaQueryData _mediaQueryData;
  //This make design responsive when orientation change & should be used with scrolling screens.
  static Size _switchableDesignSize() {
    return orientation == Orientation.portrait
        ? _designSize
        : const Size(895, 414);
  }

  void init(BuildContext context) {
      _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height -
        AppBar().preferredSize.height -
        _mediaQueryData.padding.top -
        _mediaQueryData.padding.bottom;
    statusBarHeight = _mediaQueryData.padding.top;
    systemNavBarHeight = _mediaQueryData.padding.bottom;
    textScaleFactor = _mediaQueryData.textScaleFactor;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
    orientation = _mediaQueryData.orientation;
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * .024
        : screenWidth * .024;
  }

  static double scaleWidth() => screenWidth / _switchableDesignSize().width;

  static double scaleHeight() => (_splitScreenMode
      ? max(screenHeight, 700)
      : screenHeight / _switchableDesignSize().height);

  static double scaleRadius() => min(scaleWidth(), scaleHeight());

  static double scaleText() => min(scaleWidth(), scaleHeight());
}
