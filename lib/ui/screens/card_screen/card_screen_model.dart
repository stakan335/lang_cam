import 'package:flutter_tts/flutter_tts.dart';

class CardsScreenModel {
  void textToSpeech(String word, String studyLang) async {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setLanguage(studyLang);
    await _speak(flutterTts, word);
  }

  Future _speak(FlutterTts flutterTts, String word) async {
    var result = await flutterTts.speak(word);
  }

  Future _stop(FlutterTts flutterTts) async {
    var result = await flutterTts.stop();
  }
}
