import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lang_cam/ui/library/primary_button.dart';
import 'package:lang_cam/ui/screens/sign_up/bloc/sign_up_cubit.dart';

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
              BlocProvider.of<SignUpCubit>(context).onSignUpTapped(
                email:
                    BlocProvider.of<SignUpCubit>(context).emailController.text,
                password: BlocProvider.of<SignUpCubit>(context)
                    .passwordController
                    .text,
              );
            },
            width: double.infinity,
            text: 'Sign up',
          ),
        ],
      ),
    );
  }
}
