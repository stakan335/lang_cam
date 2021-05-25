import 'package:firebase_auth/firebase_auth.dart';

import 'package:lang_cam/arch/di/buisness_logic_di.dart';
import 'package:lang_cam/arch/di/di_manager.dart';
import 'package:lang_cam/arch/services/auth_service.dart';

class AuthServiceDI implements BusinessLogicDi {
  AuthService _authService;

  @override
  void dispose() {
    DiManager.getIt.resetLazySingleton(
      instance: DiManager.getIt<User>(),
    );
  }

  @override
  void inject() {
    DiManager.getIt.registerLazySingleton<AuthService>(
      () {
        return _authService;
      },
    );
  }

  void initUser(AuthService service) => _authService = service;
}
