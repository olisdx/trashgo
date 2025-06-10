import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:latlong2/latlong.dart';

import '../../../common/currency_formatter.dart';
import '../../../common/mediaquery.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../core/themes/app_font.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/trashmap_cubit.dart';

class MenuAction extends StatelessWidget {
  const MenuAction({super.key, required this.currentLoc});

  final LatLng currentLoc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MQ.w(context),
      padding: EdgeInsets.only(top: 10, right: 24, left: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        spacing: 16,
        children: [
          Container(
            height: 3,
            width: MQ.w(context) * 0.2,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Row(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  int point =
                      (state is ProfileLoaded)
                          ? state.profile.first.get("point")
                          : 0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("POINT", style: Typograph.headline12),
                      CurrencyFormatter.formattedRP(
                        point,
                        Typograph.headline28,
                        Typograph.regular16,
                      ),
                    ],
                  );
                },
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.router.push(
                    ReportRoute(
                      currentLoc: currentLoc,
                      onCallback: () {
                        context.read<TrashmapCubit>().onRefresh();
                        context.read<ProfileCubit>().onRefresh();
                      },
                    ),
                  );
                },
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withValues(alpha: 0.5),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    TablerIcons.camera,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              SizedBox(width: 24),
              InkWell(
                onTap: () => context.router.push(ScanRoute()),
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withValues(alpha: 0.5),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(TablerIcons.scan, color: Colors.white, size: 32),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
