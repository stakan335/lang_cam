import 'package:flutter/material.dart';
import 'package:lang_cam/statics/assets.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/ui/library/header.dart';
import 'package:lang_cam/ui/screens/auth_screen/components/auth_fab.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AuthFab(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      backgroundColor: LibraryColors.mainBackgroundScreen,
      body: Center(
        child: Image.asset(
          LibraryAssets.logo,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
