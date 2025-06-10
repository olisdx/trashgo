import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/themes/app_color.dart';
import '../../../gen/assets.gen.dart';
import '../cubit/trashmap_cubit.dart';

class TrashMap extends StatelessWidget {
  const TrashMap({super.key, required this.currentLoc});
  final LatLng currentLoc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrashmapCubit, TrashmapState>(
      builder: (context, state) {
        if (state is TrashmapLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.black),
          );
        }
        if (state is TrashmapLoaded) {
          return FlutterMap(
            options: MapOptions(initialCenter: currentLoc, initialZoom: 18),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers:
                    state.maps.map((e) {
                      GeoPoint geoPoint = e["location"];
                      return Marker(
                        point: LatLng(geoPoint.latitude, geoPoint.longitude),
                        child: Assets.images.mapPin.image(),
                        height: 32,
                        width: 32,
                      );
                    }).toList(),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
