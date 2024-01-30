import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle textStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      height: height,
      fontSize: fontSize ?? 14,
      decoration: decoration,
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
