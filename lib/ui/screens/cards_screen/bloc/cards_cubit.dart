import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_cam/ui/screens/cards_screen/bloc/cards_states.dart';
import 'package:lang_cam/ui/screens/settings_screen/bloc/settings_state.dart';

import 'package:bloc/bloc.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(const CardsState.defaultState());
  String currentStudyLang;
  String currentNativeLang;

  Future<void> onScreenOpened() async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      String token = user.uid;

      final CollectionReference<Map<String, dynamic>> cardsCollection =
          FirebaseFirestore.instance
              .collection('profile')
              .doc(token)
              .collection('cards');

      setListener(cardsCollection);

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await cardsCollection.get();

      List<Map<String, dynamic>> cards =
          querySnapshot.docs.map((doc) => doc.data()).toList();

      emit(CardsState.dataLoaded(
          nativeLang: currentNativeLang, studyLang: currentStudyLang));
    } catch (e) {
      emit(CardsState.failure());
    }
  }

  Future<void> setListener(
      CollectionReference<Map<String, dynamic>> cardsCollection) async {
    cardsCollection.snapshots().listen((event) {
      emit(CardsState.dataLoaded(
          nativeLang: currentNativeLang, studyLang: currentStudyLang));
    });
  }
}
