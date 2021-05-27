import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_cam/ui/screens/settings_screen/bloc/settings_state.dart';

import 'package:bloc/bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState.defaultState());
  String currentStudyLang;
  String currentNativeLang;

  Future<void> onScreenOpened() async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      String token = user.uid;

      final DocumentReference setSnapshot =
          FirebaseFirestore.instance.collection('profile').doc(token);

      setListener(setSnapshot);

      final DocumentSnapshot documentSnapshot = await setSnapshot.get();

      currentNativeLang = documentSnapshot['nativeLang'];
      currentStudyLang = documentSnapshot['studyLang'];

      emit(SettingsState.dataLoaded(
          nativeLang: currentNativeLang, studyLang: currentStudyLang));
    } catch (e) {
      emit(SettingsState.failure());
    }
  }

  Future<void> onNativeChanged(String lang) async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      String token = user.uid;

      var ref = FirebaseFirestore.instance.doc('profile/$token');
      ref.set({'nativeLang': lang, 'studyLang': currentStudyLang});
    } catch (e) {
      emit(SettingsState.failure());
    }
  }

  Future<void> onStudyChanged(String lang) async {
    try {
      User user = FirebaseAuth.instance.currentUser;
      String token = user.uid;

      var ref = FirebaseFirestore.instance.doc('profile/$token');
      ref.set({'nativeLang': currentNativeLang, 'studyLang': lang});
    } catch (e) {
      emit(SettingsState.failure());
    }
  }

  Future<void> setListener(DocumentReference setSnapshot) async {
    setSnapshot.snapshots().listen((event) {
      currentNativeLang = event['nativeLang'];
      currentStudyLang = event['studyLang'];

      emit(SettingsState.dataLoaded(
          nativeLang: currentNativeLang, studyLang: currentStudyLang));
    });
  }
}
