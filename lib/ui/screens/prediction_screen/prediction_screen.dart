import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lang_cam/ui/screens/prediction_screen/prediction_screen_model.dart';

import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

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

  List _recognitions;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
    ssdMobileNet(pictureForPredction.path);
  }

  void onButtonTapped() async {
    ssdMobileNet(pictureForPredction.path);
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String res;

      res = await Tflite.loadModel(
        model: "assets/cats_dogs1.tflite",
        labels: "assets/labels1.txt",
        // useGpuDelegate: true,
      );

      print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future ssdMobileNet(String path) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.detectObjectOnImage(
      path: path,
      numResultsPerClass: 1,
    );
    setState(() {
      _recognitions = recognitions;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (pictureForPredction != null)
            Container(
              child: Image.file(File(pictureForPredction.path)),
            ),
          GestureDetector(
            onTap: () async {
              onButtonTapped();
            },
            child: Container(
              color: Colors.black,
              height: 61,
              width: double.infinity,
              child: _recognitions != null
                  ? Center(
                      child: Text(
                        "${_recognitions[0]["detectedClass"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
