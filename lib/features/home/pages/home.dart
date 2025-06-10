import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../location/cubit/location_user_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/trashmap_cubit.dart';
import 'home_page.dart';

@RoutePage(name: "root")
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationUserCubit()),
        BlocProvider(create: (_) => TrashmapCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
      ],
      child: HomePage(),
    );
  }
}
