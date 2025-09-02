import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_tcs/features/features.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  @override
  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }
}
