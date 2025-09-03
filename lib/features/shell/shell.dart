import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tcs/features/navigation_bar/domain/entities/destination_route.dart';
import 'package:prueba_tcs/features/navigation_bar/presentation/screens/navigation_bar.dart';
import 'package:prueba_tcs/features/navigation_bar/presentation/widgets/destination.dart';

class Shell extends StatefulWidget {
  const Shell({required this.child, super.key});
  final StatefulNavigationShell child;
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomNavigationBar(
        destinations: const <DestinationRoute>[
          DestinationRoute(
            page: 0,
            path: '/home',
            destinaton: Destination(icon: Icons.home, label: 'Inicio'),
          ),
          DestinationRoute(
            page: 1,
            path: '/reports',
            destinaton: Destination(icon: Icons.bar_chart, label: 'Reportes'),
          ),
          DestinationRoute(
            page: 2,
            path: '/account',
            destinaton: Destination(icon: Icons.person, label: 'Cuenta'),
          ),
        ],
      ),
    );
  }
}
