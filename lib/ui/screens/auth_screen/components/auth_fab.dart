import 'package:flutter/material.dart';
import 'package:lang_cam/domain/navigation/screen_navigation.dart';
import 'package:lang_cam/statics/routes.dart';

import 'package:lang_cam/ui/library/primary_button.dart';
import 'package:camera/camera.dart';

class AuthFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            onPressed: () {
              ScreenNavigation.routeTo(
                  route: LibraryRoutes.signUp, context: context);
            },
            width: double.infinity,
            text: 'Sign up',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            onPressed: () {
              ScreenNavigation.routeTo(
                  route: LibraryRoutes.signIn, context: context);
            },
            width: double.infinity,
            text: 'Log in',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            onPressed: () async {
              List<CameraDescription> cameras = await availableCameras();
              ScreenNavigation.routeTo(
                route: LibraryRoutes.camScreen,
                context: context,
                bundle: <String, dynamic>{
                  'cameras': cameras,
                },
              );
            },
            width: double.infinity,
            text: 'Cam',
          ),
        ],
      ),
    );
  }
}
