import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/config/app/presentation/bloc/app_bloc.dart';
import 'package:prueba_tcs/config/router/go_router_refresh_stream.dart';
import 'package:prueba_tcs/features/features.dart';
import 'package:prueba_tcs/features/loading/loading_screen.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class AppRouter {
  final AppBloc _appBloc = sl<AppBloc>();

  late final appRouter = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(stream: _appBloc.stream),
    redirect: (context, state) {
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
    routes: [
      GoRoute(path: '/', builder: (context, state) => LoadingScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    ],
  );
}
