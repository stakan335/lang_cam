import 'dart:io';
import 'package:tflite/tflite.dart';

class PredictionScreenModel {
  loadMyModel() async {
    var model = await Tflite.loadModel(
      model: "assets/cats_dogs.tflite",
      labels: "assets/labels.txt",
    );
    print(model);
    return model;
  }

  predictObjectOnPicture(String path) async {
    var result = await Tflite.runModelOnImage(
      path: path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 255,
      imageStd: 255,
    );
    return result;
  }
}
