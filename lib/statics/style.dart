import 'package:flutter/widgets.dart';
import 'package:lang_cam/statics/colors.dart';

class LibraryStyles {
  static TextStyle mainText({
    double fontSize = 16,
    Color color = LibraryColors.mainBackgroundScreen,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal,
        color: color,
      );
}
