import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:lang_cam/statics/statics.dart';

import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({
    this.cameras,
  });

  final List<CameraDescription> cameras;
  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  @override
  CameraController controller;
  // Future<void> _initializeControllerFuture;
  XFile imageFile;

  @override
  void initState() {
    super.initState();
    print(widget.cameras[0]);
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    // _initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: LibraryColors.mainBackgroundScreen,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          controller.takePicture().then((XFile file) {
            if (mounted) {
              setState(() {
                imageFile = file;
              });
            }
          });
        },
      ),
      body: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: imageFile != null
                ? Container(
                    child: Image.file(File(imageFile.path)),
                  )
                : CameraPreview(controller),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
