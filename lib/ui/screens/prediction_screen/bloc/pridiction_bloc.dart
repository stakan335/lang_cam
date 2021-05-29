import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:lang_cam/ui/screens/prediction_screen/bloc/prediction_state.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tflite/tflite.dart';
import 'package:translator/translator.dart';
import 'package:camera/camera.dart';

import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';

class PredictionCubit extends Cubit<PredictionState> {
  PredictionCubit() : super(const PredictionState.defaultState());
  String currentStudyLang;
  String currentNativeLang;
  List<dynamic> currentRecognations;

  Future<void> onScreenOpened(XFile imageFile) async {
    try {
      emit(PredictionState.loading());
      User user = FirebaseAuth.instance.currentUser;
      String token = user.uid;

      final DocumentReference setSnapshot =
          FirebaseFirestore.instance.collection('profile').doc(token);

      final DocumentSnapshot documentSnapshot = await setSnapshot.get();

      currentNativeLang = documentSnapshot['nativeLang'];
      currentStudyLang = documentSnapshot['studyLang'];

      loadModel().then((val) {});
      List<dynamic> recognations = await ssdMobileNet(imageFile.path);
      Tflite.close();
      currentRecognations = recognations;

      translateAll();

      setListener(setSnapshot);
    } catch (e) {
      emit(PredictionState.failure());
    }
  }

  Future<void> setListener(DocumentReference setSnapshot) async {
    setSnapshot.snapshots().listen((event) {
      currentNativeLang = event['nativeLang'];
      currentStudyLang = event['studyLang'];
      emit(PredictionState.loading());
      translateAll();
    });
  }

  Future<void> translateAll() async {
    List<String> translations = await translateResults(
        input: currentRecognations, lang: currentNativeLang);

    List<String> recognationsTraslations;

    if (currentStudyLang != 'en') {
      recognationsTraslations = await translateResults(
          input: currentRecognations, lang: currentStudyLang);
    } else {
      currentRecognations.forEach((recognation) {
        recognationsTraslations = recognation['label'];
      });
    }

    emit(PredictionState.dataLoaded(
        recognations: currentRecognations,
        translations: translations,
        recognationsTranslations: recognationsTraslations,
        studyLang: currentStudyLang));
  }

  Future<List<dynamic>> ssdMobileNet(String path) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");

    return recognitions;
  }

  Future loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
        model: "assets/mobilenet_v2_1.0_224.tflite",
        labels: "assets/labels_mobilenet_quant_v1_224.txt",
        // isAsset: true,
        // useGpuDelegate: true,
      );

      // print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future<List<String>> translateResults({
    List<dynamic> input,
    String lang = 'ru',
  }) async {
    final translator = GoogleTranslator();

    List<String> translations = [];
    for (int index = 0; index < input.length; index++) {
      Translation translationResult = await translator
          .translate(input[index]["label"], from: 'en', to: lang);

      translations.add(translationResult.text);
    }

    return translations;
  }

  //save logic
  Future<void> save(XFile imageFile) async {
    User user = FirebaseAuth.instance.currentUser;
    String token = user.uid;

    Reference storageReference =
        FirebaseStorage.instance.ref().child('$token/${imageFile.name}');

    Uuid uuid = Uuid();
    String id = uuid.v1();

    File file = File(imageFile.path);
    UploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.whenComplete(() => print('File Uploaded'));

    String downloadUrl = await storageReference.getDownloadURL();

    var ref = FirebaseFirestore.instance.doc('profile/$token/cards/$id');
    ref.set({
      'imagePath': downloadUrl,
      'recognitions': currentRecognations,
    });
  }
}
