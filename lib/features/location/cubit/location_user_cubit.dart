import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../common/location_handler.dart';

part 'location_user_state.dart';

class LocationUserCubit extends Cubit<LocationUserState> {
  LocationUserCubit() : super(LocationUserInitial()) {
    _getCurrentPosition();
  }

  Future<void> onRefresh() async => _getCurrentPosition();

  Future<void> _getCurrentPosition() async {
    if (state is LocationUserLoading) return;
    emit(LocationUserLoading());

    final result = await LocationHandler.getCurrentPosition();

    result.fold((l) async {
      if (l == LocationFailed.needPermission) {
        return emit(LocationUserNeedPermission());
      }
      if (l == LocationFailed.permissionDenied) {
        return emit(LocationUserFailure());
      }
      if (l == LocationFailed.denied) {
        return emit(LocationUserDenied());
      }
      if (l == LocationFailed.fakeGps) {
        return emit(LocationUserFakeGps());
      }
      emit(LocationNotFound());
    }, (r) => emit(LocationUserLoaded(r)));
  }
}
