import 'package:creen/core/utils/extensions/num_extensions.dart';
import 'package:creen/core/utils/responsive/responsive_service.dart';


class Sizes {
  static screenHeight() =>
      ResponsiveService.screenHeight;

  static screenWidth() =>
      ResponsiveService.screenWidth;

  static statusBarHeight() =>
      ResponsiveService.statusBarHeight;

  static systemNavBarHeight() =>
      ResponsiveService.systemNavBarHeight;

  //Font sizes
  static fontSizes() => {
        "h0": 40.0.sp,
        "h1": 32.0.sp,
        "h2": 24.0.sp,
        "h3": 20.0.sp,
        "h4": 17.0.sp,
        "h5": 14.0.sp,
        "h6": 12.0.sp,
      };

  //Icons sizes
  static iconsSizes() => {
        "s1": 95.r,
        "s2": 70.r,
        "s3": 48.r,
        "s4": 32.r,
        "s5": 24.r,
        "s6": 19.r,
        "s7": 14.r,
      };

  //Screens Padding
  static screenVPaddingDefault() => 20.h();
  static screenHPaddingDefault() => 40.w();
  static screenVPaddingHigh() => 80.h();
  static screenHPaddingMedium() => 36.w();

  //Widgets Padding
  static vPaddingHighest() => 40.h();
  static vPaddingHigh() => 30.h();
  static vPaddingMedium() => 22.h();
  static vPaddingSmall() => 16.h();
  static vPaddingSmallest() => 10.h();
  static vPaddingTiny() => 5.h();
  static hPaddingHighest() => 40.w();
  static hPaddingHigh() => 30.w();
  static hPaddingMedium() => 22.w();
  static hPaddingSmall() => 16.w();
  static hPaddingSmallest() => 10.w();
  static hPaddingTiny() => 5.w();

  //Widgets Margin
  static vMarginExtreme() => 80.h();
  static vMarginHighest() => 40.h();
  static vMarginHigh() => 30.h();
  static vMarginMedium() => 22.h();
  static vMarginSmall() => 16.h();
  static vMarginSmallest() => 10.h();
  static vMarginComment() => 8.h();
  static vMarginTiny() => 5.h();
  static vMarginDot() => 3.h();
  static hMarginExtreme() => 70.w();
  static hMarginHighest() => 40.w();
  static hMarginHigh() => 30.w();
  static hMarginMedium() => 22.w();
  static hMarginSmall() => 16.w();
  static hMarginSmallest() => 10.w();
  static hMarginComment() => 8.w();
  static hMarginTiny() => 5.w();
  static hMarginDot() => 3.w();

  //Buttons
  static roundedButtonMinHeight() => 40.h();
  static roundedButtonDefaultHeight() => 70.h();
  static roundedButtonDefaultWidth() => 300.w();
  static roundedButtonDefaultRadius() => 26.r();
  static roundedButtonDialogHeight() => 44.h();
  static roundedButtonDialogWidth() => 240.w();
  static roundedButtonHighWidth() => 260.w();
  static roundedButtonMediumHeight() => 44.h();
  static roundedButtonMediumWidth() => 140.w();
  static roundedButtonSmallWidth() => 116.w();
  static textButtonMinWidth() => 60.w();
  static textButtonMinHeight() => 34.h();

  //TextFields
  static textFieldDefaultRadius() => 12.r();
  static textFieldVMarginMedium() => 24.h();
  static textFieldHPaddingMedium() => 16.w();
  static textFieldVPaddingMedium() => 16.h();

  //Cards
  static cardVPadding() => 16.h();
  static cardHRadius() => 20.w();
  static cardRadius() => 14.r();

  //Dialogs
  static dialogVPadding() => 30.h();
  static dialogHPadding() => 20.w();
  static dialogRadius() => 24.r();
  static dialogHPaddingMedium() => 10.w();
  static dialogHPaddingSmall() => 4.w();
  static dialogSmallRadius() => 6.r();

  //LoadingIndicators
  static loadingAnimationDefaultHeight() => 150.h();
  static loadingAnimationDefaultWidth() => 150.w();
  static loadingIndicatorDefaultHeight() => 150.r();
  static loadingIndicatorDefaultWidth() => 150.r();
  static loadingListViewDefaultHeight() => 150.h();
  static loadingListViewDefaultWidth() => 136.w();
  static loadingAnimationButton() => 90.r();

  //Images
  static userImageSmallRadius() => 30.r();
  static userImageMediumRadius() => 56.r();
  static userImageHighRadius() => 66.r();
  static statusCircleRadius() => 8.r();
  static qrImageRadius() => 100.r();
  static pickedImageMaxSize() => 400.r();

  //Text
  static smallTextHeight() => 1.4.h();

  //Map
  static mapSearchBarHeight() => 54.h();
  static mapSearchBarTopMargin() => 50.h();
  static mapSearchBarRadius() => 8.r();
  static mapDirectionsInfoTop() => 116.h();
  static mapDirectionsInfoRadius() => 20.r();
  static mapConfirmButtonBottom() => 42.h();
  static mapConfirmButtonLeft() => 40.w();

  //AppBar & Drawer
  static appBarDefaultHeight() => 90.h();
  static appBarStatusBarHeight() => 24.h();
  static mainDrawerWidth() => 250.w();
  static mainDrawerHPadding() => 30.w();
  static mainDrawerVPadding() => 90.h();
  static appBarIconSize() => 26.r();
  static snackBarRadius() => 20.r();

  ///App Constants
  static screenTopShadowHeight() => 400.h();
  static splashLogoSize() => 220.r();
  static loginLogoSize() => 126.r();
  static switchThemeButtonWidth() => 44.w();
}
