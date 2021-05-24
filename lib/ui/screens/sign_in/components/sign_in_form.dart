import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lang_cam/ui/library/text_form_input.dart';
import 'package:lang_cam/ui/screens/sign_in/bloc/sign_in_cubit.dart';
import 'package:lang_cam/ui/screens/sign_up/bloc/sign_up_cubit.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: BlocProvider.of<SignInCubit>(context).formKey,
        child: Column(
          children: [
            TextFormInput(
              label: 'Email',
              showLabel: true,
              textEditingController:
                  BlocProvider.of<SignInCubit>(context).emailController,
            ),
            const SizedBox(height: 20),
            TextFormInput(
              label: 'Password',
              showLabel: true,
              textEditingController:
                  BlocProvider.of<SignInCubit>(context).passwordController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
