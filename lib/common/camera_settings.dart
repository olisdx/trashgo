import 'dart:io';

import 'package:camera/camera.dart';

import 'app_info.dart';

enum CameraPosition { front, back }

abstract class CameraSettings {
  //* Initializes the camera controller with the default settings.
  //* Default CameraPosition is *CameraPosition.back* and default enableAudio is *false*.
  //* CameraPosition.front* for front camera and *CameraPosition.back* for back camera.
  //* enableAudio for enable/disable audio.
  static CameraController defaults({
    CameraPosition? position,
    bool enableAudio = false,
  }) => CameraController(
    getCamera(position),
    ResolutionPreset.veryHigh,
    enableAudio: enableAudio,
    imageFormatGroup: getImageFormatGroup(),
  );

  static CameraDescription getCamera([CameraPosition? position]) {
    if (position == CameraPosition.front) {
      if (AppInfo.instance.cameras.length > 1) {
        return AppInfo.instance.cameras[1];
      } else {
        return AppInfo.instance.cameras.first;
      }
    } else {
      return AppInfo.instance.cameras.first;
    }
  }

  static ImageFormatGroup getImageFormatGroup() =>
      Platform.isAndroid ? ImageFormatGroup.yuv420 : ImageFormatGroup.bgra8888;
}
