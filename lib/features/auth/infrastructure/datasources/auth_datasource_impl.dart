import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba_tcs/features/features.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final _auth = FirebaseAuth.instance;

  @override
  Future createUser(String email, String password) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return (credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 1;
      } else if (e.code == 'email-already-in-use') {
        return 2;
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  @override
  Future loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 1;
      } else if (e.code == 'wrong-password') {
        return 2;
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }
}
