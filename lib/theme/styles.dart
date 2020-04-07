import 'package:flutter/material.dart';

class FontSizes {
  static double scale = 1.3;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get title => 16 * scale;
}
 
class TextStyles {
  static TextStyle get titleFont => TextStyle(fontWeight: FontWeight.bold);
 
  static TextStyle get title => titleFont.copyWith(fontSize: FontSizes.title);
  static TextStyle get titleLight => title.copyWith(fontWeight: FontWeight.w300);
 
  static TextStyle get body => TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}