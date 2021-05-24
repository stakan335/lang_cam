import 'package:flutter/material.dart';
import 'package:lang_cam/statics/colors.dart';
import 'package:lang_cam/statics/style.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput({
    this.label = '',
    this.placeholder = '',
    this.validator,
    this.keyboardType = TextInputType.text,
    this.showLabel = false,
    this.textEditingController,
    this.fillColor = LibraryColors.mainYellow,
  });

  final String label;
  final String placeholder;
  final bool showLabel;
  final TextEditingController textEditingController;
  final Function(String) validator;
  final TextInputType keyboardType;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: LibraryStyles.mainText(
                color: LibraryColors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        if (showLabel)
          SizedBox(
            height: 10,
          ),
        TextFormField(
          controller: textEditingController,
          obscureText: false,
          validator: validator,
          keyboardType: keyboardType,
          cursorColor: fillColor,
          style: LibraryStyles.mainText(color: LibraryColors.white),
          decoration: InputDecoration(
            hoverColor: fillColor,
            focusColor: fillColor,
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 5),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: LibraryColors.opacityYellow),
              borderRadius: BorderRadius.circular(0),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: LibraryColors.opacityYellow),
              borderRadius: BorderRadius.circular(0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: LibraryColors.mainYellow),
              borderRadius: BorderRadius.circular(0),
            ),
            fillColor: fillColor,
            hintStyle: LibraryStyles.mainText(color: LibraryColors.white),
            hintText: placeholder,
          ),
        ),
      ],
    );
  }
}
