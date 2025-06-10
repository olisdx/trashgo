import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  static Future<bool> requestCameraPermission() async {
    if (await Permission.camera.isDenied) {
      final status = await Permission.camera.request();
      if (status.isGranted) return true;
      return false;
    }
    if (await Permission.camera.isPermanentlyDenied) {
      return await openAppSettings().then((value) => false);
    }
    return true;
  }

  static Future<bool> requestLocationPermission() async {
    if (await Permission.locationWhenInUse.isDenied) {
      final status = await Permission.locationWhenInUse.request();
      if (status.isGranted) return true;
      return false;
    } else if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      return await openAppSettings().then((value) => false);
    }
    return true;
  }
}
