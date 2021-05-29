import 'package:flutter/cupertino.dart';
import 'package:lang_cam/domain/data/lang_card_data.dart';
import 'package:lang_cam/ui/screens/cards_screen/components/lang_card.dart';

class ListLangCards extends StatelessWidget {
  const ListLangCards({this.langCardWidgetDataList});

  final List<LangCardWidgetData> langCardWidgetDataList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildCards(langCardWidgetDataList),
    );
  }

  List<Widget> _buildCards(List<LangCardWidgetData> langCardWidgetDataList) {
    List<Widget> langCardsList = [];

    langCardWidgetDataList.forEach((langCardData) {
      langCardsList.add(LangCard(
        data: langCardData,
      ));
    });

    return langCardsList;
  }
}
