import 'package:flutter/material.dart';

import 'package:lang_cam/ui/screens/sign_in/bloc/sign_in_states.dart';

import 'package:bloc/bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState.defaultState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onLogInTapped({
    String email,
    String password,
  }) async {
    print(email);
    print(password);
  }
}
