import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:prueba_tcs/config/app/presentation/screens/app_screen.dart';

import 'package:prueba_tcs/features/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  serviceLocatorInit();
  runApp(const AppScreen());
}

// class BlocProviders extends StatelessWidget {
//   const BlocProviders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
//       child: AppScreen(),
//     );
//   }
// }
