import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:lang_cam/statics/google_langs.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/statics/style.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({this.onSelectedItemChanged});

  final Function(int) onSelectedItemChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          child: CupertinoPicker(
            itemExtent: 40,
            useMagnifier: true,
            onSelectedItemChanged: onSelectedItemChanged,
            children: buildLangs(),
          ),
        ),
      ],
    );
  }

  List<Widget> buildLangs() {
    List<Widget> langs = [];
    googleLangs.forEach(
      (key, value) {
        langs.add(
          Text(
            '$value',
            style: LibraryStyles.mainText(
                fontSize: 20, color: LibraryColors.mainBackgroundScreen),
          ),
        );
      },
    );
    return langs;
  }
}
