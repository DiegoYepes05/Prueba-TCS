import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/config/app/presentation/bloc/app_bloc.dart';
import 'package:prueba_tcs/config/router/go_router_refresh_stream.dart';
import 'package:prueba_tcs/features/account/presentation/screens/account_screen.dart';
import 'package:prueba_tcs/features/create_reports/presentation/screens/create_reports_screen.dart';
import 'package:prueba_tcs/features/details_reports/presentation/screens/detail_reports.dart';
import 'package:prueba_tcs/features/features.dart';
import 'package:prueba_tcs/features/home/presentation/screens/home_screen.dart';
import 'package:prueba_tcs/features/loading/loading_screen.dart';
import 'package:prueba_tcs/features/reports/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/service_locator.dart';
import 'package:prueba_tcs/features/shell/shell.dart';

class AppRouter {
  final AppBloc _appBloc = sl<AppBloc>();
  final GlobalKey<NavigatorState> _parentNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<StatefulNavigationShellState> _shellKey =
      GlobalKey<StatefulNavigationShellState>();
  late final GoRouter appRouter = GoRouter(
    navigatorKey: _parentNavigatorKey,
    initialLocation: '/',

    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(stream: _appBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      final AuthStatus authStatus = _appBloc.state.authStatus;
      final String currentLocation = state.matchedLocation;
      if (authStatus == AuthStatus.unAuthenticated &&
          !<String>['/login', '/register'].contains(currentLocation)) {
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated &&
          <String>['/login', '/register', '/'].contains(currentLocation)) {
        return '/home';
      }
      if (authStatus == AuthStatus.initial && currentLocation == '/') {
        return '/';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const LoadingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        key: _shellKey,
        parentNavigatorKey: _parentNavigatorKey,
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return Shell(child: navigationShell);
            },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage<HomeScreen>(child: HomeScreen()),
              ),
              GoRoute(
                path: '/account',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage<AccountScreen>(
                      child: AccountScreen(),
                    ),
              ),
              GoRoute(
                path: '/reports',
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const NoTransitionPage<ReportsScreen>(
                      child: ReportsScreen(),
                    ),
                routes: <RouteBase>[
                  GoRoute(
                    parentNavigatorKey: _parentNavigatorKey,
                    path: 'create/:category',
                    builder: (BuildContext context, GoRouterState state) {
                      final int category = int.parse(
                        state.pathParameters['category']!,
                      );
                      return CreateReportsScreen(
                        category: Category.values[category],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterScreen(),
      ),
      GoRoute(
        path: '/details/:id',
        builder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id']!;
          return DetailsReportsScreen(id: id);
        },
      ),
    ],
  );
}
