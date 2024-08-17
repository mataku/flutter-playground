import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:state_app/page/discover_screen.dart';
import 'package:state_app/page/home_screen.dart';
import 'package:state_app/page/top_screen.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routes: $appRoutes,
  initialLocation: HomeRoute.path,
);

@TypedShellRoute<TopShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: HomeRoute.path),
    TypedGoRoute<DiscoverRoute>(path: DiscoverRoute.path),
  ],
)
class TopShellRoute extends ShellRouteData {
  const TopShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return TopScreen(child: navigator);
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
