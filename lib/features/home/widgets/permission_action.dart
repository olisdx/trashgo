import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:geolocator/geolocator.dart';

import '../../../common/mediaquery.dart';
import '../../../common/permission_handler.dart';
import '../../../common/primary_button.dart';
import '../../../core/themes/app_font.dart';
import '../../location/cubit/location_user_cubit.dart';

class PermissionAction extends StatelessWidget {
  const PermissionAction({super.key, required this.isDenied});

  final bool isDenied;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(TablerIcons.map_cancel, size: 120, color: Colors.red),
          SizedBox(height: 24),
          Text(
            isDenied ? "Enable Location" : "Permission Needed",
            style: Typograph.headline18,
          ),
          SizedBox(height: 16),
          PrimaryButton(
            width: MQ.w(context) * 0.5,
            text: "Accepted",
            onPressed: () async {
              if (isDenied) {
                Geolocator.openLocationSettings();
              } else {
                await PermissionHandler.requestLocationPermission();
              }
              if (!context.mounted) return;
              context.read<LocationUserCubit>().onRefresh();
            },
          ),
        ],
      ),
    );
  }
}
