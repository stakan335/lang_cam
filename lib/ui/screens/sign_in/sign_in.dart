import 'package:flutter/material.dart';
import 'package:lang_cam/statics/colors.dart';

import 'package:lang_cam/ui/library/header.dart';

import 'package:lang_cam/ui/screens/sign_in/components/sign_in_fab.dart';
import 'package:lang_cam/ui/screens/sign_in/components/sign_in_form.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SignUpFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: LibraryColors.mainBackgroundScreen,
      body: Column(
        children: [
          Header(text: 'Log in'),
          const SizedBox(height: 20),
          SignInForm(),
        ],
      ),
    );
  }
}
