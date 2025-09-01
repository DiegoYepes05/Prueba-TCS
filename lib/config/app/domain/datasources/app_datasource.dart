import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AppDatasource {
  Stream<User?> authStatus();
}
