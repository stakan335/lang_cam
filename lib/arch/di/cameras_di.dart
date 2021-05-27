import 'package:lang_cam/arch/di/buisness_logic_di.dart';
import 'package:lang_cam/arch/di/di_manager.dart';
import 'package:camera/camera.dart';

class CamerasDI implements BusinessLogicDi {
  List<CameraDescription> _cameras;

  @override
  void dispose() {
    DiManager.getIt.resetLazySingleton(
      instance: DiManager.getIt<List<CameraDescription>>(),
    );
  }

  @override
  void inject() {
    DiManager.getIt.registerLazySingleton<List<CameraDescription>>(
      () {
        return _cameras;
      },
    );
  }

  void initCameras(List<CameraDescription> cameras) => _cameras = cameras;
}
