import 'package:flutter/material.dart';

class CustomWidgets {
  static Text text(
    String content, {
    Color? color,
    double? fontSize = 13,
    FontWeight? fontWeight = FontWeight.normal,
    int? maxLine,
    double? letterSpacing = 0.0,
    TextAlign? textAlign,
    double? height = 1.7,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    return Text(
      content,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      style: TextStyle(
        letterSpacing: letterSpacing,
        color: color,
        fontSize: fontSize!,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}
