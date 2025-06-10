import 'package:auto_route/auto_route.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_font.dart';
import '../cubit/trash_cubit.dart';

@RoutePage()
class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrashCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Trash Location")),
        body: BlocBuilder<TrashCubit, TrashState>(
          builder: (context, state) {
            if (state is TrashLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.black),
              );
            }
            if (state is TrashLoaded) {
              return ListView.separated(
                separatorBuilder: (_, __) => SizedBox(height: 12),
                padding: EdgeInsets.all(16),
                itemCount: state.maps.length,
                itemBuilder: (context, index) {
                  final data = state.maps[index];

                  return Container(
                    padding: EdgeInsets.all(16),
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            Text(data["title"], style: Typograph.subtitle14),
                            Text(
                              data["description"],
                              style: Typograph.regular14,
                            ),
                          ],
                        ),
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FancyShimmerImage(imageUrl: data["image"]),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
