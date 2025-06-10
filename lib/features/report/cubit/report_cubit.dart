import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:latlong2/latlong.dart';

import '../../../common/api_url.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  Future<void> postData({
    required String title,
    required String description,
    required LatLng location,
    required CameraController cameraController,
  }) async {
    if (state is ReportLoading) return;
    emit(ReportLoading());

    try {
      final imageUrl = await _uploadImage(cameraController);

      // posy trash map
      await FirebaseFirestore.instance.collection(ApiUrl.trashmap).add({
        'title': title.trim(),
        'description': description.trim(),
        'image': imageUrl,
        'location': GeoPoint(location.latitude, location.longitude),
      });

      final currentPoint = await _getCurrentPoint();
      // add point
      await FirebaseFirestore.instance
          .collection(ApiUrl.profile)
          .doc("currency")
          .update({"point": currentPoint + 25000});

      emit(ReportLoaded());
    } catch (e) {
      emit(ReportFailure());
    }
  }

  Future<String> _uploadImage(CameraController cameraController) async {
    final photo = await cameraController.takePicture();

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance.ref().child('uploads/$fileName.jpg');

    await ref.putFile(File(photo.path));
    return await ref.getDownloadURL();
  }

  Future<int> _getCurrentPoint() async {
    final snapshot =
        await FirebaseFirestore.instance.collection(ApiUrl.profile).get();

    return snapshot.docs.first.get("point");
  }
}
