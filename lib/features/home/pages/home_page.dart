import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/router/app_router.gr.dart';
import '../../../core/themes/app_color.dart';
import '../../location/cubit/location_user_cubit.dart';
import '../widgets/menu_action.dart';
import '../widgets/permission_action.dart';
import '../widgets/search_trash.dart';
import '../widgets/trash_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<LocationUserCubit, LocationUserState>(
            builder: (context, state) {
              if (state is LocationUserNeedPermission) {
                return PermissionAction(isDenied: false);
              }
              if (state is LocationUserDenied) {
                return PermissionAction(isDenied: true);
              }
              if (state is LocationUserLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.black),
                );
              }
              if (state is LocationUserLoaded) {
                return Stack(
                  children: [
                    TrashMap(currentLoc: state.latLng),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        spacing: 12,
                        children: [
                          Flexible(child: SearchTrash()),
                          InkWell(
                            onTap: () => context.router.push(TrashRoute()),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(TablerIcons.recycle),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 16,
                        children: [
                          InkWell(
                            onTap:
                                () =>
                                    context
                                        .read<LocationUserCubit>()
                                        .onRefresh(),
                            child: Container(
                              width: 42,
                              height: 42,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.my_location),
                            ),
                          ),
                          MenuAction(currentLoc: state.latLng),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
