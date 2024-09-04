import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sunrisescrob/store/session_store.dart';
import 'package:sunrisescrob/ui/account/account_screen.dart';
import 'package:sunrisescrob/ui/account/theme_selection_screen.dart';
import 'package:sunrisescrob/ui/auth/login_screen.dart';
import 'package:sunrisescrob/ui/detail/track_detail_screen.dart';
import 'package:sunrisescrob/ui/discover/discover_screen.dart';
import 'package:sunrisescrob/ui/home/home_screen.dart';
import 'package:sunrisescrob/ui/top_screen.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _discoverNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _accountNavigatorKey =
    GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  final sessionStore = ref.read(sessionStoreProvider);
  return GoRouter(
    routes: $appRoutes,
    initialLocation: HomeRoute.path,
    navigatorKey: _rootNavigatorKey,
    redirect: (BuildContext context, GoRouterState state) async {
      final sessionKey = await sessionStore.getSessionKey();
      final bool loggedIn = sessionKey?.isNotEmpty ?? false;
      final toHome = state.matchedLocation == const HomeRoute().location;
      if (toHome && !loggedIn) {
        return const LoginRoute().location;
      }
      return null;
    },
    refreshListenable: ref.watch(sessionChangeNotifierProvider),
  );
});

@TypedStatefulShellRoute<TopShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(
          path: HomeRoute.path,
          routes: [
            TypedGoRoute<TrackDetailRoute>(
              path: TrackDetailRoute.path,
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<DiscoverShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DiscoverRoute>(path: DiscoverRoute.path),
      ],
    ),
    TypedStatefulShellBranch<AccountShellBranchData>(
      routes: [
        TypedGoRoute<AccountRoute>(path: AccountRoute.path, routes: [
          TypedGoRoute<ThemeSelectionRoute>(
            path: ThemeSelectionRoute.path,
          )
        ]),
      ],
    )
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

@TypedGoRoute<AccountRoute>(path: AccountRoute.path)
class AccountRoute extends GoRouteData {
  const AccountRoute();

  static const path = '/account';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountScreen();
  }
}

class TrackDetailRoute extends GoRouteData {
  final String artist;
  final String track;

  const TrackDetailRoute({
    required this.artist,
    required this.track,
  });

  static const path = 'track_detail';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TrackDetailScreen(
      artist: artist,
      track: track,
    );
  }
}

class ThemeSelectionRoute extends GoRouteData {
  const ThemeSelectionRoute();

  static const path = "select_theme";

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ThemeSelectionScreen();
  }
}

@TypedGoRoute<LoginRoute>(
  path: LoginRoute.path,
)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  static const path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginScreen();
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

class AccountShellBranchData extends StatefulShellBranchData {
  const AccountShellBranchData();

  static final GlobalKey<NavigatorState> $navigatorKey = _accountNavigatorKey;
}
