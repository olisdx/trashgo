import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/api_url.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    _getProfile();
  }

  Future<void> onRefresh() async => _getProfile();

  Future<void> _getProfile() async {
    emit(ProfileLoading());
    final snapshot =
        await FirebaseFirestore.instance.collection(ApiUrl.profile).get();
    emit(ProfileLoaded(snapshot.docs));
  }
}
