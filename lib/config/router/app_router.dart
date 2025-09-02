import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/config/app/presentation/bloc/app_bloc.dart';
import 'package:prueba_tcs/config/router/go_router_refresh_stream.dart';
import 'package:prueba_tcs/features/create_reports/presentation/screens/create_reports_screen.dart';
import 'package:prueba_tcs/features/features.dart';
import 'package:prueba_tcs/features/home/domain/entities/report_entity.dart';
import 'package:prueba_tcs/features/loading/loading_screen.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class AppRouter {
  final AppBloc _appBloc = sl<AppBloc>();
  final GlobalKey<NavigatorState> _formKey = GlobalKey<NavigatorState>();
  late final GoRouter appRouter = GoRouter(
    navigatorKey: _formKey,
    initialLocation: '/',

    //! Todo:
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
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: _formKey,
            path: 'create/:category',
            builder: (BuildContext context, GoRouterState state) {
              final int category = int.parse(state.pathParameters['category']!);
              return CreateReportsScreen(category: Category.values[category]);
            },
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
    ],
  );
}
