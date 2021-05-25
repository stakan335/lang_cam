import 'package:get_it/get_it.dart';

class DiManager {
  static GetIt _getIt;

  static void init() {
    _getIt = GetIt.instance;
    _getIt.allowReassignment = true;
  }

  static GetIt get getIt => _getIt;
}
