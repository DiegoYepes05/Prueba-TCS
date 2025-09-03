import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tcs/config/app/presentation/bloc/app_bloc.dart';
import 'package:prueba_tcs/config/router/app_router.dart';
import 'package:prueba_tcs/config/theme/app_dark_theme.dart';
import 'package:prueba_tcs/config/theme/app_light_theme.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    super.initState();
    AppLightTheme.initialize(context);
    AppDarkTheme.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (BuildContext context) => sl<AppBloc>()..add(GetUser()),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          return MaterialApp.router(
            theme: AppLightTheme.instance,

            title: 'Prueba TCS',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter().appRouter,
          );
        },
      ),
    );
  }
}
