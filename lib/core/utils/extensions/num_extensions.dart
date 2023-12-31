import '../responsive/responsive_service.dart';

extension SizeExtension on num {
  double w() => ResponsiveService.scaleWidth() * this;

  double h() => ResponsiveService.scaleHeight() * this;

  double r() => ResponsiveService.scaleRadius() * this;

  double sp() => ResponsiveService.scaleText() * this;
}
