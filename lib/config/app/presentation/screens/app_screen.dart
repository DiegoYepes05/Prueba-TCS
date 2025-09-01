import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/config/app/presentation/bloc/app_bloc.dart';
import 'package:prueba_tcs/config/router/app_router.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppBloc>()..add(GetUser()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Prueba TCS',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter().appRouter,
          );
        },
      ),
    );
  }
}
