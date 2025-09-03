import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tcs/config/app/presentation/bloc/app_bloc.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late final AppBloc _appBloc;
  @override
  void initState() {
    super.initState();
    _appBloc = sl<AppBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cuenta'),
      ),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _appBloc.state.user?.email ?? '',
              style: const TextStyle(color: Colors.black),
            ),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green[200],
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
