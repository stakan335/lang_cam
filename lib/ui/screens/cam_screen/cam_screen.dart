import 'dart:io';

import 'package:flutter/material.dart';

import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/domain/navigation/screen_navigation.dart';
import 'package:lang_cam/statics/routes.dart';

import 'package:camera/camera.dart';

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
        child: Icon(Icons.camera),
        onPressed: () async {
          controller.takePicture().then((XFile file) {
            if (mounted) {
              ScreenNavigation.routeTo(
                route: LibraryRoutes.predictionScreen,
                context: context,
                bundle: <String, dynamic>{
                  'imageFile': file,
                },
              );
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 30.0,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
            ),
          ),
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
          Container(
            color: Colors.black,
            height: 30,
          ),
        ],
      ),
    );
  }
}
