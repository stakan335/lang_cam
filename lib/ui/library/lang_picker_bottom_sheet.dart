import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lang_cam/statics/colors.dart';
import 'package:lang_cam/statics/style.dart';
import 'package:lang_cam/ui/library/language_picker.dart';
import 'package:lang_cam/ui/library/primary_button.dart';
import 'package:lang_cam/statics/google_langs.dart';

class LangPickerBottomSheet extends StatefulWidget {
  @override
  _LangPickerBottomSheetState createState() => _LangPickerBottomSheetState();
}

class _LangPickerBottomSheetState extends State<LangPickerBottomSheet> {
  int languageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: LibraryColors.opacityYellow,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20,
            ),
            topRight: Radius.circular(
              20,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Text(
              'Select native language',
              style: LibraryStyles.mainText(
                  fontSize: 27, color: LibraryColors.mainBackgroundScreen),
            ),
            LanguagePicker(
              onSelectedItemChanged: (int index) {
                languageIndex = index;
              },
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  googleLangs.keys.elementAt(languageIndex),
                );
              },
              text: 'Select',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
