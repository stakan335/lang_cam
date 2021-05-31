import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/statics/style.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lang_cam/ui/screens/cards_screen/bloc/cards_cubit.dart';

class LangCardWidgetData {
  const LangCardWidgetData({
    this.id,
    this.imageUrl,
    this.text,
    this.translation,
    this.lang,
  });

  final String id;

  final String imageUrl;
  final String text;
  final String translation;
  final String lang;
}

class LangCard extends StatelessWidget {
  const LangCard({
    this.data,
  });

  final LangCardWidgetData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        BlocProvider.of<CardsCubit>(context).deleteCard(data.id);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(20)),
                child: Image.network(
                  data.imageUrl,
                  height: MediaQuery.of(context).size.height / 5,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            data.text,
                            style: LibraryStyles.mainText(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: LibraryColors.mainYellow),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            data.translation,
                            style: LibraryStyles.mainText(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: LibraryColors.opacityYellow),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        textToSpeech(data.text, data.lang);
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
