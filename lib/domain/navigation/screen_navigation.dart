import 'package:flutter/widgets.dart';
import 'package:lang_cam/statics/routes.dart';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lang_cam/ui/screens/cam_screen/cam_screen.dart';

class ScreenNavigation {
  static void routeTo({
    @required String route,
    @required BuildContext context,
    dynamic bundle,
  }) {
    switch (route) {
      case LibraryRoutes.camScreen:
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => CamScreen(),
          ),
        );
        break;
      case LibraryRoutes.pop:
        Navigator.of(context).pop();
        break;
      default:
    }
  }
}
