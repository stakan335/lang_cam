import 'package:flutter/material.dart';

import 'package:lang_cam/ui/library/primary_button.dart';
import 'package:lang_cam/ui/screens/sign_in/bloc/sign_in_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            onPressed: () {
              BlocProvider.of<SignInCubit>(context).onLogInTapped(
                email:
                    BlocProvider.of<SignInCubit>(context).emailController.text,
                password: BlocProvider.of<SignInCubit>(context)
                    .passwordController
                    .text,
              );
            },
            width: double.infinity,
            text: 'Log in',
          ),
        ],
      ),
    );
  }
}
