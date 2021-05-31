import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_cam/domain/data/lang_card_data.dart';
import 'package:lang_cam/ui/screens/cards_screen/bloc/cards_states.dart';

import 'package:bloc/bloc.dart';
import 'package:lang_cam/ui/screens/cards_screen/components/lang_card.dart';
import 'package:translator/translator.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(const CardsState.defaultState());
  String currentStudyLang;
  String currentNativeLang;
  List<LangCardData> currentLangCardsDataList;
  List<LangCardWidgetData> langCardWidgetDataList = [];
  List<LangCardWidgetData> langChangedCardWidgetDataList = [];

  Future<void> onScreenOpened() async {
    try {
      emit(CardsState.loading());
      User user = FirebaseAuth.instance.currentUser;
      String token = user.uid;

      final CollectionReference<Map<String, dynamic>> cardsCollection =
          FirebaseFirestore.instance
              .collection('profile')
              .doc(token)
              .collection('cards');

      final DocumentReference langSnapshot =
          FirebaseFirestore.instance.collection('profile').doc(token);

      final DocumentSnapshot documentSnapshot = await langSnapshot.get();

      currentNativeLang = documentSnapshot['nativeLang'];
      currentStudyLang = documentSnapshot['studyLang'];

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cardsCollection.get();

      await emitCards(querySnapshot);

      Future.delayed(Duration(seconds: 5));
      setLangListener(langSnapshot);
      setCardsListener(cardsCollection);
    } catch (e) {
      emit(CardsState.failure());
    }
  }

  Future<void> setLangListener(DocumentReference setSnapshot) async {
    setSnapshot.snapshots().listen((event) async {
      emit(CardsState.loading());
      currentNativeLang = event['nativeLang'];
      currentStudyLang = event['studyLang'];
      langCardWidgetDataList = await translateAll();

      emit(CardsState.dataLoaded(
        nativeLang: currentNativeLang,
        studyLang: currentStudyLang,
        langCardsDataList: langCardWidgetDataList,
      ));
    });
  }

  Future<void> setCardsListener(
      CollectionReference<Map<String, dynamic>> cardsCollection) async {
    cardsCollection.snapshots().listen((event) async {
      emit(CardsState.loading());
      await emitCards(event);

      langCardWidgetDataList = await translateAll();

      emit(CardsState.dataLoaded(
        nativeLang: currentNativeLang,
        studyLang: currentStudyLang,
        langCardsDataList: langCardWidgetDataList,
      ));
    });
  }

  Future<void> emitCards(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) async {
    List<Map<String, dynamic>> cards =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    currentLangCardsDataList =
        cards.map((card) => LangCardData.fromJson(card)).toList();
    langCardWidgetDataList = [];
  }

  Future<List<LangCardWidgetData>> translateAll() async {
    int cardsCount = currentLangCardsDataList.length;

    List<LangCardWidgetData> langCardWidgetDataListLocal = [];

    for (int i = 0; i < cardsCount; i++) {
      langCardWidgetDataListLocal.add(LangCardWidgetData(
          imageUrl: currentLangCardsDataList[i].imageUrl,
          text: await translateResults(
              input: currentLangCardsDataList[i].recognitions[0].label,
              to: currentStudyLang),
          translation: await translateResults(
              input: currentLangCardsDataList[i].recognitions[0].label,
              to: currentNativeLang),
          lang: currentStudyLang,
          id: currentLangCardsDataList[i].id));
    }

    return langCardWidgetDataListLocal;
  }

  Future<String> translateResults({
    String input,
    String to,
  }) async {
    final translator = GoogleTranslator();

    Translation translationResult =
        await translator.translate(input, from: 'en', to: to);

    return translationResult.text;
  }

  Future<void> deleteCard(String id) async {
    User user = FirebaseAuth.instance.currentUser;
    String token = user.uid;

    FirebaseFirestore.instance
        .collection('profile')
        .doc(token)
        .collection('cards')
        .doc(id)
        .delete()
        .then((value) {
      print("Success!");
    });
  }
}
