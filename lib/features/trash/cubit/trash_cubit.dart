import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/api_url.dart';

part 'trash_state.dart';

class TrashCubit extends Cubit<TrashState> {
  TrashCubit() : super(TrashInitial()) {
    _getTrashLocation();
  }

  Future<void> onRefresh() async => _getTrashLocation();

  Future<void> _getTrashLocation() async {
    emit(TrashLoading());
    final snapshot =
        await FirebaseFirestore.instance.collection(ApiUrl.trashmap).get();
    emit(TrashLoaded(snapshot.docs));
  }
}
