import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/features/navigation_bar/domain/entities/destination_route.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({required this.destinations, super.key})
    : assert(
        destinations.length > 1,
        'destinations must contain at least two items',
      );
  final List<DestinationRoute> destinations;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _getPage({required String location}) {
    final DestinationRoute? matchingRoute =
        widget.destinations.firstWhereOrNull(
          (DestinationRoute dest) => location == dest.path,
        ) ??
        widget.destinations.firstWhereOrNull(
          (DestinationRoute dest) => location.startsWith(dest.path),
        );
    return matchingRoute?.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return GoRouterBuilder(
      builder: (BuildContext context, GoRouterState state, Widget? child) {
        final String currentLocation = state.uri.path;
        final int currentPage = _getPage(location: currentLocation);
        return NavigationBar(
          animationDuration: const Duration(milliseconds: 200),
          maintainBottomViewPadding: true,
          selectedIndex: currentPage,
          onDestinationSelected: (int value) {
            if (value == currentPage) {
              return;
            }

            final String targetPath = widget.destinations[value].path;
            final String initialPath = widget.destinations.first.path;
            if (value == 0 && currentLocation != initialPath) {
              context.pop();
            } else if (currentLocation == initialPath) {
              context.push(targetPath);
            } else {
              context.pushReplacement(targetPath);
            }
          },

          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelPadding: const EdgeInsets.only(top: 12),

          destinations: widget.destinations
              .map((DestinationRoute route) => route.destinaton)
              .toList(),
        );
      },
    );
  }
}

class GoRouterBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    GoRouterState state,
    Widget? child,
  )
  builder;
  final Widget? child;

  const GoRouterBuilder({required this.builder, super.key, this.child});

  @override
  State<GoRouterBuilder> createState() => _GoRouterBuilderState();
}

class _GoRouterBuilderState extends State<GoRouterBuilder>
    with WidgetsBindingObserver {
  late final GoRouter _router;
  late GoRouterState _state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _router = GoRouter.of(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = _router.state;
    _router.routerDelegate.addListener(_handleRouteChange);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _state = GoRouter.of(context).state;
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  void _handleRouteChange() {
    final GoRouterState currentState = _router.state;
    if (_state.uri.path != currentState.uri.path) {
      setState(() {
        _state = currentState;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _router.routerDelegate.removeListener(_handleRouteChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el estado actual en cada build para capturar cambios inmediatos
    final GoRouterState currentState = GoRouter.of(context).state;
    return widget.builder(context, currentState, widget.child);
  }
}
