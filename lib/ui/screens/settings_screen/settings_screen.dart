import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lang_cam/domain/navigation/screen_navigation.dart';
import 'package:lang_cam/statics/colors.dart';
import 'package:lang_cam/statics/routes.dart';
import 'package:lang_cam/ui/library/header.dart';
import 'package:lang_cam/ui/library/primary_button.dart';
import 'package:lang_cam/ui/library/lang_picker_bottom_sheet.dart';

import 'package:lang_cam/ui/screens/auth_screen/bloc/auth_cubit.dart';
import 'package:lang_cam/ui/screens/settings_screen/bloc/settings_cubit.dart';
import 'package:lang_cam/ui/screens/settings_screen/bloc/settings_state.dart';
import 'package:lang_cam/statics/google_langs.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SettingsCubit>(context).onScreenOpened();
    return Scaffold(
      backgroundColor: LibraryColors.mainBackgroundScreen,
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (_, state) {
          return Column(
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
                      return LangPickerBottomSheet(
                        initialValue: state.nativeLang,
                      );
                    },
                  );
                  if (data != null) {
                    BlocProvider.of<SettingsCubit>(context)
                        .onNativeChanged(data);
                  }
                },
                text: 'Native languge: ${googleLangs[state.nativeLang]}',
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
                      return LangPickerBottomSheet(
                        initialValue: state.studyLang,
                      );
                    },
                  );
                  if (data != null) {
                    BlocProvider.of<SettingsCubit>(context)
                        .onStudyChanged(data);
                  }
                },
                text: 'Study languge: ${googleLangs[state.studyLang]}',
              ),
            ],
          );
        },
      ),
    );
  }
}
