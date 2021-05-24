import 'package:flutter/material.dart';

import 'package:lang_cam/ui/screens/sign_up/bloc/sign_up_states.dart';

import 'package:bloc/bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState.defaultState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> onSignUpTapped({
    String email,
    String password,
    String firstName,
    String secondName,
  }) async {
    print(email);
    print(password);
    print(firstName);
    print(secondName);
  }
}
