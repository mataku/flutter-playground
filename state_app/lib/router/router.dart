import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:state_app/page/discover_screen.dart';
import 'package:state_app/page/home_screen.dart';
import 'package:state_app/page/top_screen.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _discoverNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
    routes: $appRoutes,
    initialLocation: HomeRoute.path,
    navigatorKey: _rootNavigatorKey);

@TypedStatefulShellRoute<TopShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(path: HomeRoute.path),
      ],
    ),
    TypedStatefulShellBranch<DiscoverShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DiscoverRoute>(path: DiscoverRoute.path),
      ],
    ),
  ],
)
class TopShellRoute extends StatefulShellRouteData {
  const TopShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state,
      StatefulNavigationShell navigationShell) {
    return TopScreen(navigationShell: navigationShell);
  }
}

@TypedGoRoute<HomeRoute>(path: HomeRoute.path)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const path = '/home';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<DiscoverRoute>(path: DiscoverRoute.path)
class DiscoverRoute extends GoRouteData {
  const DiscoverRoute();

  static const path = '/discover';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DiscoverScreen();
  }
}

class HomeShellBranchData extends StatefulShellBranchData {
  const HomeShellBranchData();

  static final GlobalKey<NavigatorState> $navigatorKey = _homeNavigatorKey;
}

class DiscoverShellBranchData extends StatefulShellBranchData {
  const DiscoverShellBranchData();

  static final GlobalKey<NavigatorState> $navigatorKey = _discoverNavigatorKey;
}
