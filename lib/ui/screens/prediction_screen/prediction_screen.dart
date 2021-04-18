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

  List _recognitions;
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
    setState(() {
      _recognitions = recognationResult;
    });
  }

  void onButtonTapped() async {
    viewModel.ssdMobileNet(pictureForPredction.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                width: double.infinity,
                child: _recognitions != null
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: buildRecognationResults(_recognitions),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecognationResults(List<dynamic> recognations) {
    List<Widget> results = [];
    recognations.asMap().forEach(
      (index, value) {
        results.add(
          Text(
            "${_recognitions[index]["label"]}",
            style: TextStyle(
              fontSize: index == 0 ? 20 : 14,
              fontWeight: FontWeight.bold,
              color: index == 0 ? Colors.white : Colors.grey,
            ),
          ),
        );
      },
    );
    return results;
  }
}
