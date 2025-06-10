import 'package:camera/camera.dart';

class AppInfo {
  AppInfo._internal();
  static final AppInfo _instance = AppInfo._internal();
  static AppInfo get instance => _instance;

  late List<CameraDescription> _cameras;

  Future<void> init() async {
    await _checkCamera();
  }

  Future<void> _checkCamera() async => _cameras = await availableCameras();

  List<CameraDescription> get cameras => _cameras;
}
