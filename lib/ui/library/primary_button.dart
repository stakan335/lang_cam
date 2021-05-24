import 'package:flutter/material.dart';
import 'package:lang_cam/statics/statics.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    this.text,
    this.onPressed,
    this.width,
    this.height = 50,
    this.elevation = 5,
    this.color = LibraryColors.mainYellow,
    this.disabledColor = LibraryColors.opacityYellow,
    this.pressedColor = LibraryColors.pressedYellow,
    this.shadowColor = LibraryColors.white,
  });

  final String text;
  final double width;
  final double height;
  final double elevation;
  final Color color;
  final Color disabledColor;
  final Color pressedColor;
  final Color shadowColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: Text(text),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            onPressed != null ? color : disabledColor),
        overlayColor: MaterialStateProperty.all<Color>(pressedColor),
        shadowColor: MaterialStateProperty.all<Color>(shadowColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return 0;
          }
          if (states.contains(MaterialState.focused)) {
            return elevation;
          }
          if (states.contains(MaterialState.hovered)) {
            return elevation;
          }
          if (states.contains(MaterialState.disabled)) {
            return 0;
          }
          return elevation;
        }),
      ),
    );
  }
}
