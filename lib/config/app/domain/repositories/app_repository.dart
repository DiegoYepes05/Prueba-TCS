import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AppRepository {
  Stream<User?> authStatus();
}
