import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lang_cam/arch/di/auth_service_di.dart';
import 'package:lang_cam/arch/di/cameras_di.dart';
import 'package:lang_cam/arch/di/di_manager.dart';
import 'package:lang_cam/arch/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:camera/camera.dart';
import 'package:lang_cam/domain/navigation/screen_navigation.dart';
import 'package:lang_cam/statics/routes.dart';
import 'package:lang_cam/statics/statics.dart';
import 'package:lang_cam/ui/screens/auth_screen/auth_screen.dart';
import 'package:lang_cam/ui/screens/auth_screen/bloc/auth_cubit.dart';
import 'package:lang_cam/ui/screens/auth_screen/bloc/auth_state.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
  DiManager.init();
  CamerasDI()
    ..initCameras(cameras)
    ..inject();
  AuthServiceDI()
    ..initUser(AuthService(FirebaseAuth.instance))
    ..inject();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Cam recognizer',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).checkAuthListener();
    return Container(
      color: LibraryColors.mainBackgroundScreen,
      child: BlocConsumer<AuthCubit, AuthState>(
        cubit: BlocProvider.of<AuthCubit>(context),
        listener: (_, state) {
          if (state.status == AuthStatus.signedIn) {
            ScreenNavigation.routeTo(
                route: LibraryRoutes.home, context: context);
          } else {
            ScreenNavigation.routeTo(
                route: LibraryRoutes.auth, context: context);
          }
        },
        builder: (_, state) {
          return Container();
        },
      ),
    );
  }
}
