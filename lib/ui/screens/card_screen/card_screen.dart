import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_cam/statics/colors.dart';
import 'package:lang_cam/ui/library/primary_button.dart';
import 'package:lang_cam/ui/screens/card_screen/card_screen_model.dart';
import 'package:lang_cam/ui/screens/prediction_screen/bloc/prediction_state.dart';
import 'package:lang_cam/ui/screens/prediction_screen/bloc/pridiction_bloc.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({this.imageUrl});

  final String imageUrl;
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String get imageUrl => widget.imageUrl;

  CardsScreenModel viewModel = CardsScreenModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionCubit, PredictionState>(
      builder: (_, state) {
        if (state.status == PredictionStatus.dataLoaded) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    if (imageUrl != null)
                      Container(
                        child: Image.network(imageUrl),
                      ),
                    if (state.recognations != null &&
                        state.translations != null)
                      Column(
                        children: buildRecognationResults(
                            state.recognations,
                            state.recognationsTranslations,
                            state.translations,
                            state.studyLang),
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: LibraryColors.mainBackgroundScreen,
            valueColor: AlwaysStoppedAnimation<Color>(
              LibraryColors.mainYellow,
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildRecognationResults(
    List<dynamic> recognations,
    List<String> recognationsTranslations,
    List<String> translations,
    String studyLang,
  ) {
    List<Widget> results = [];

    recognations.asMap().forEach(
      (index, value) {
        results.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                viewModel.textToSpeech(
                    recognationsTranslations[index], studyLang);
              },
              child: Ink(
                height: 69,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: index == 0 ? Colors.yellow : Colors.grey,
                )),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${recognationsTranslations[index]} (${(recognations[index]["confidence"] * 100).toStringAsFixed(0)}%) -",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: index == 0 ? 20 : 14,
                              fontWeight: index == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: index == 0 ? Colors.white : Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${translations[index]}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: index == 0 ? 20 : 14,
                              fontWeight: index == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: index == 0 ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.volume_down,
                      color: index == 0 ? Colors.yellow : Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return results;
  }
}
