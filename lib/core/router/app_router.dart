import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: Root.page, initial: true),
    AutoRoute(page: ReportRoute.page),
    AutoRoute(page: TrashRoute.page),
    AutoRoute(page: ScanRoute.page),
    AutoRoute(page: PayRoute.page),
  ];
}
