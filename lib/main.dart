import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/app_info.dart';
import 'common/logger.dart';
import 'core/router/app_router.dart';
import 'core/themes/app_theme.dart';

void main() => Main();

class Main extends InitialApp {
  @override
  FutureOr<StatelessWidget> onCreate() {
    ErrorWidget.builder = (details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return const SizedBox.shrink();
    };
    return MyApp();
  }
}

abstract class InitialApp {
  InitialApp() {
    _init();
  }

  FutureOr<StatelessWidget> onCreate();

  Future<void> _init() async {
    await runZonedGuarded(
      () async {
        try {
          await _initializeApp();

          final app = await onCreate();
          runApp(app);
        } catch (error, _) {
          rethrow;
        }
      },
      (error, stack) {
        _handleInitializationError(error, stack);
      },
    );
  }

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await AppInfo.instance.init();
    await _configureSystemChrome();
  }

  Future<void> _configureSystemChrome() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "TrashGo",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _appRouter.config(),
    );
  }
}

void _handleInitializationError(dynamic e, StackTrace s) {
  Log.e("APP EXCEPTION", e, stackTrace: s);
}
