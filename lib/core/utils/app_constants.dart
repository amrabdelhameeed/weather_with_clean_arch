import 'package:flutter/material.dart';
import 'size_config.dart';

class AppConstants {
  AppConstants._();
  static const Duration animationDuration = Duration(milliseconds: 500);
  static final double maxScroll = SizeConfig.defaultSize! * 10;
  static double panelPosition = SizeConfig.defaultSize! * 8;
  static final pageHorizontalPadding = EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 1.2);
  static const locationIcon = Icon(
    Icons.location_on,
    color: Colors.white,
  );
}
