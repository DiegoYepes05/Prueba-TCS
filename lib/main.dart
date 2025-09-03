import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tcs/config/app/presentation/screens/app_screen.dart';
import 'package:prueba_tcs/features/service_locator.dart';
import 'package:prueba_tcs/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  serviceLocatorInit();
  runApp(const AppScreen());
}
