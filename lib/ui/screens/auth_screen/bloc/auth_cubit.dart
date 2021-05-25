import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lang_cam/arch/services/auth_service.dart';
import 'package:lang_cam/ui/screens/auth_screen/bloc/auth_state.dart';

import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.defaultState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> checkAuth() async {
    AuthService authService = AuthService(FirebaseAuth.instance);
    authService.onAuthStateChanged.listen((user) {
      if (user == null) {
        emit(AuthState.failure());
      } else {
        emit(AuthState.signedIn());
      }
    });
  }
}
