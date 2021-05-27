import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lang_cam/arch/di/di_manager.dart';
import 'package:lang_cam/arch/services/auth_service.dart';

import 'package:lang_cam/ui/screens/sign_up/bloc/sign_up_states.dart';

import 'package:bloc/bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState.defaultState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onSignUpTapped({
    String email,
    String password,
  }) async {
    AuthService authService = DiManager.getIt<AuthService>();

    bool isCompleted =
        await authService.signUp(email: email, password: password);

    if (isCompleted) {
      writeProfileData({
        'nativeLang': 'ru',
        'studyLang': 'en',
      });
      emit(SignUpState.complited());
    } else {
      emit(SignUpState.failure());
    }
  }

  Future<void> writeProfileData(Map<String, dynamic> profileData) async {
    User user = FirebaseAuth.instance.currentUser;
    String token = user.uid;
    var ref = FirebaseFirestore.instance.doc('profile/$token');
    ref.set(profileData);
  }
}
