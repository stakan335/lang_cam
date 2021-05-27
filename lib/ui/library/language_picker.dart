import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:lang_cam/statics/google_langs.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/statics/style.dart';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({this.onSelectedItemChanged, this.initialValue});

  final Function(int) onSelectedItemChanged;
  final int initialValue;

  @override
  _LanguagePickerState createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  FixedExtentScrollController controller;
  @override
  void initState() {
    controller = FixedExtentScrollController(initialItem: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          child: CupertinoPicker(
            scrollController: controller,
            itemExtent: 40,
            useMagnifier: true,
            onSelectedItemChanged: widget.onSelectedItemChanged,
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
