import 'package:firebase_auth/firebase_auth.dart';

import 'package:lang_cam/arch/di/buisness_logic_di.dart';
import 'package:lang_cam/arch/di/di_manager.dart';

class CurrentUserDI implements BusinessLogicDi {
  User _currentUser;

  @override
  void dispose() {
    DiManager.getIt.resetLazySingleton(
      instance: DiManager.getIt<User>(),
    );
  }

  @override
  void inject() {
    DiManager.getIt.registerLazySingleton<User>(
      () {
        return _currentUser;
      },
    );
  }

  void initUser(User user) => _currentUser = user;
}
