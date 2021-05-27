import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_cam/statics/routes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lang_cam/ui/screens/auth_screen/auth_screen.dart';
import 'package:lang_cam/ui/screens/auth_screen/bloc/auth_cubit.dart';

import 'package:lang_cam/ui/screens/cam_screen/cam_screen.dart';
import 'package:lang_cam/ui/screens/home_screen/home_screen.dart';
import 'package:lang_cam/ui/screens/prediction_screen/prediction_screen.dart';
import 'package:lang_cam/ui/screens/sign_in/bloc/sign_in_cubit.dart';
import 'package:lang_cam/ui/screens/sign_in/sign_in.dart';
import 'package:lang_cam/ui/screens/sign_up/bloc/sign_up_cubit.dart';
import 'package:lang_cam/ui/screens/sign_up/sign_up.dart';

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
            builder: (BuildContext context) => CamScreen(
              cameras: bundle['cameras'],
            ),
          ),
        );
        break;
      case LibraryRoutes.predictionScreen:
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => PredictionScreen(
              imageFile: bundle['imageFile'],
            ),
          ),
        );
        break;
      case LibraryRoutes.auth:
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => BlocProvider<AuthCubit>(
              create: (_) => AuthCubit(),
              child: AuthScreen(),
            ),
          ),
        );
        break;
      case LibraryRoutes.signUp:
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => BlocProvider<SignUpCubit>(
              create: (_) => SignUpCubit(),
              child: SignUp(),
            ),
          ),
        );
        break;
      case LibraryRoutes.signIn:
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => BlocProvider<SignInCubit>(
              create: (_) => SignInCubit(),
              child: SignIn(),
            ),
          ),
        );
        break;
      case LibraryRoutes.home:
        Navigator.of(context).push(
          MaterialPageRoute<Widget>(
            builder: (BuildContext context) => HomeScreen(),
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
