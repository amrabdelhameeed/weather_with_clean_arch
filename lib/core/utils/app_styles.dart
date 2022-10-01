import 'package:flutter/material.dart';
import 'size_config.dart';

class AppStyles {
  static const bigLightWhiteStyle = TextStyle(fontSize: 55, color: Colors.white, fontWeight: FontWeight.w200);
  static const midLightWhiteStyle = TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w400);
  static const smallLightWhiteStyle = TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500);
  static final tooSmallWhiteStyle = TextStyle(fontSize: SizeConfig.defaultSize! * 1, color: Colors.white, fontWeight: FontWeight.w400);
  static final whiteBoxDecoration = BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white));
}
