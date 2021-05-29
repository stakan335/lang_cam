import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/statics/style.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LangCard extends StatelessWidget {
  const LangCard({this.imageUrl, this.text, this.translation, this.lang});

  final String imageUrl;
  final String text;
  final String translation;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Ink(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
          color: LibraryColors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.network(
                imageUrl,
                height: MediaQuery.of(context).size.height / 5,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: LibraryStyles.mainText(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: LibraryColors.mainYellow),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        translation,
                        style: LibraryStyles.mainText(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: LibraryColors.opacityYellow),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      textToSpeech(text, lang);
                    },
                    splashColor: LibraryColors.secondYellow.withOpacity(0.3),
                    highlightColor:
                        LibraryColors.opacityYellow.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    child: Ink(
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.volume_down,
                        color: Colors.yellow,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
