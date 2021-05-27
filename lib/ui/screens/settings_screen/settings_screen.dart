import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_cam/domain/navigation/screen_navigation.dart';
import 'package:lang_cam/statics/colors.dart';
import 'package:lang_cam/statics/routes.dart';
import 'package:lang_cam/ui/library/header.dart';
import 'package:lang_cam/ui/library/primary_button.dart';
import 'package:lang_cam/ui/library/lang_picker_bottom_sheet.dart';

import 'package:lang_cam/ui/screens/auth_screen/bloc/auth_cubit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LibraryColors.mainBackgroundScreen,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Header(),
          PrimaryButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logOut();
              ScreenNavigation.routeTo(
                  route: LibraryRoutes.auth, context: context);
            },
            text: 'Log Out',
          ),
          PrimaryButton(
            onPressed: () async {
              final data = await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(
                      20,
                    ),
                  ),
                ),
                builder: (BuildContext context) {
                  return LangPickerBottomSheet();
                },
              );
              print(data);
            },
            text: 'Select native languge',
          ),
        ],
      ),
    );
  }
}
