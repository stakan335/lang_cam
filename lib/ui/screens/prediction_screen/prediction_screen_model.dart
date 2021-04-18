import 'dart:async';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';

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
      String res;

      res = await Tflite.loadModel(
        model: "assets/mobilenet_v1_1.0_224.tflite",
        labels: "assets/labels_mobilenet_quant_v1_224.txt",
        // isAsset: true,
        // useGpuDelegate: true,
      );

      // print(res);
    } on PlatformException {
      print('Failed to load model.');
    }
  }
}
