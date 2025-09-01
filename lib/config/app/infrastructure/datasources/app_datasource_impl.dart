import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_tcs/config/app/domain/datasources/app_datasource.dart';

class AppDatasourceImpl implements AppDatasource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<User?> authStatus() {
    return firebaseAuth.userChanges();
  }
}
