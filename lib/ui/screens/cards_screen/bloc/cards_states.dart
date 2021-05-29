import 'package:lang_cam/domain/data/lang_card_data.dart';
import 'package:lang_cam/ui/screens/cards_screen/components/lang_card.dart';

class CardsState {
  const CardsState._({
    this.status,
    this.nativeLang,
    this.studyLang,
    this.langCardWidgetDataList,
  });

  const CardsState.loading()
      : this._(
          status: CardsStatus.loading,
        );

  const CardsState.defaultState()
      : this._(
          status: CardsStatus.defaultState,
        );

  const CardsState.dataLoaded({
    String nativeLang,
    String studyLang,
    List<LangCardWidgetData> langCardsDataList,
  }) : this._(
          status: CardsStatus.dataLoaded,
          nativeLang: nativeLang,
          studyLang: studyLang,
          langCardWidgetDataList: langCardsDataList,
        );

  const CardsState.failure()
      : this._(
          status: CardsStatus.failure,
        );

  final CardsStatus status;
  final String nativeLang;
  final String studyLang;
  final List<LangCardWidgetData> langCardWidgetDataList;
}

enum CardsStatus { dataLoaded, failure, defaultState, loading }
