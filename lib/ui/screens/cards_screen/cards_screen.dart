import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lang_cam/statics/colors.dart';
import 'package:lang_cam/ui/library/header.dart';
import 'package:lang_cam/ui/screens/cards_screen/bloc/cards_cubit.dart';
import 'package:lang_cam/ui/screens/cards_screen/bloc/cards_states.dart';
import 'package:lang_cam/ui/screens/cards_screen/components/lang_card.dart';
import 'package:lang_cam/ui/screens/cards_screen/components/list_lang_cards.dart';

class CardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LibraryColors.mainBackgroundScreen,
      body: BlocBuilder<CardsCubit, CardsState>(builder: (_, state) {
        if (state.status == CardsStatus.dataLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                ListLangCards(
                  langCardWidgetDataList: state.langCardWidgetDataList,
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: LibraryColors.mainBackgroundScreen,
            valueColor: AlwaysStoppedAnimation<Color>(
              LibraryColors.mainYellow,
            ),
          ),
        );
      }),
    );
  }
}
