part of 'location_user_cubit.dart';

sealed class LocationUserState {}

final class LocationUserInitial extends LocationUserState {}

final class LocationUserLoading extends LocationUserState {}

final class LocationUserFailure extends LocationUserState {}

final class LocationNotFound extends LocationUserState {}

final class LocationUserFakeGps extends LocationUserState {}

final class LocationUserDenied extends LocationUserState {}

final class LocationUserNeedPermission extends LocationUserState {}

final class LocationUserLoaded extends LocationUserState {
  final LatLng latLng;

  LocationUserLoaded(this.latLng);
}
