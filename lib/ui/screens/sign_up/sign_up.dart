import 'package:flutter/material.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/ui/library/header.dart';
import 'package:lang_cam/ui/screens/sign_up/components/sign_up_fab.dart';
import 'package:lang_cam/ui/screens/sign_up/components/sign_up_form.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SignUpFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: LibraryColors.mainBackgroundScreen,
      body: Column(
        children: [
          Header(text: 'Sign up'),
          const SizedBox(height: 20),
          SignUpForm(),
        ],
      ),
    );
  }
}
