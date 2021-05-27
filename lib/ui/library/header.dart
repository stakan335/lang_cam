import 'package:flutter/material.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/statics/style.dart';

class Header extends StatelessWidget {
  const Header({this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SafeArea(
        child: Center(
          child: Text(
            text ?? '',
            style: LibraryStyles.mainText(),
          ),
        ),
      ),
    );
  }
}
