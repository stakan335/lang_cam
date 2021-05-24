import 'dart:async';

import 'package:flutter/services.dart';

import 'package:tflite/tflite.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PredictionScreenModel {
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

  Future<List<String>> translateResults(List<dynamic> input) async {
    final translator = GoogleTranslator();

    List<String> translations = [];
    for (int index = 0; index < input.length; index++) {
      Translation translationResult = await translator
          .translate(input[index]["label"], from: 'en', to: 'ru');

      translations.add(translationResult.text);
    }

    return translations;
  }

  void textToSpeech(String word) {
    FlutterTts flutterTts = FlutterTts();
    _speak(flutterTts, word);
  }

  Future _speak(FlutterTts flutterTts, String word) async {
    var result = await flutterTts.speak(word);
  }

  Future _stop(FlutterTts flutterTts) async {
    var result = await flutterTts.stop();
  }
}
