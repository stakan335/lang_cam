import 'package:flutter/material.dart';

import 'package:lang_cam/statics/colors.dart';
import 'package:lang_cam/ui/library/header.dart';
import 'package:lang_cam/ui/screens/cards_screen/components/lang_card.dart';

class CardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LibraryColors.mainBackgroundScreen,
      body: Column(
        children: [
          Header(),
          LangCard(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/lang-cam.appspot.com/o/Oa2aWOT7Y6fAYAKZgQipPozXZSt1%2FCAP2745796770098162641.jpg%7D%7D?alt=media&token=922f213d-2adf-40d3-bc44-e2eb41e2b972',
            text: 'Camera',
            translation: 'Камера',
            lang: 'en',
          ),
        ],
      ),
    );
  }
}
