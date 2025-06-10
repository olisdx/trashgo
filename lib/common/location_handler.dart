import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permission_handler.dart';

enum LocationFailed {
  denied,
  needPermission,
  fakeGps,
  permissionDenied,
  unknown,
}

abstract class LocationHandler {
  static Future<Position> getCurrentPositionOnly({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    Duration? timeLimit,
  }) async {
    return Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: desiredAccuracy,
        timeLimit: timeLimit,
      ),
    );
  }

  static Future<Either<LocationFailed, LatLng>> getCurrentPosition({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    Duration? timeLimit,
  }) async {
    try {
      final isGrant = await Permission.location.isGranted;
      if (!isGrant) {
        return left(LocationFailed.needPermission);
      }

      final isGranted = await PermissionHandler.requestLocationPermission();
      if (!isGranted) {
        return left(LocationFailed.permissionDenied);
      }

      if (!await Geolocator.isLocationServiceEnabled()) {
        return left(LocationFailed.denied);
      }

      final currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: desiredAccuracy,
          timeLimit: timeLimit,
        ),
      );

      return right(LatLng(currentPosition.latitude, currentPosition.longitude));
    } catch (e) {
      if (e == "User denied permissions to access the device's location.") {
        return left(LocationFailed.permissionDenied);
      } else {
        return left(LocationFailed.unknown);
      }
    }
  }
}
