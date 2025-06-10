import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/api_url.dart';

part 'trashmap_state.dart';

class TrashmapCubit extends Cubit<TrashmapState> {
  TrashmapCubit() : super(TrashmapInitial()) {
    _getTrashMap();
  }

  Future<void> onRefresh() async => _getTrashMap();

  Future<void> _getTrashMap() async {
    emit(TrashmapLoading());
    final snapshot =
        await FirebaseFirestore.instance.collection(ApiUrl.trashmap).get();
    emit(TrashmapLoaded(snapshot.docs));
  }
}
