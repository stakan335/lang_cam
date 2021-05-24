import 'dart:io';

import 'package:flutter/material.dart';

import 'package:lang_cam/ui/screens/prediction_screen/prediction_screen_model.dart';

import 'package:camera/camera.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({this.imageFile});

  final XFile imageFile;
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  XFile get pictureForPredction => widget.imageFile;
  PredictionScreenModel viewModel = PredictionScreenModel();
  var model;
  var result;

  List<dynamic> _recognitions;
  List<String> _translations;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _busy = true;

    viewModel.loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      executeOnStart();
    });
  }

  Future<void> executeOnStart() async {
    List<dynamic> recognationResult =
        await viewModel.ssdMobileNet(pictureForPredction.path);

    List<String> translations =
        await viewModel.translateResults(recognationResult);
    setState(() {
      _recognitions = recognationResult;
      _translations = translations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              if (pictureForPredction != null)
                Container(
                  child: Image.file(File(pictureForPredction.path)),
                ),
              if (_recognitions != null && _translations != null)
                Column(
                  children:
                      buildRecognationResults(_recognitions, _translations),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildRecognationResults(
    List<dynamic> recognations,
    List<String> translations,
  ) {
    List<Widget> results = [];

    recognations.asMap().forEach(
      (index, value) {
        results.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                viewModel.textToSpeech(recognations[index]["label"]);
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
                            "${recognations[index]["label"]} (${(recognations[index]["confidence"] * 100).toStringAsFixed(0)}%) -",
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
