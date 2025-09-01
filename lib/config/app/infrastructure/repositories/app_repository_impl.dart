import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_tcs/config/app/domain/datasources/app_datasource.dart';
import 'package:prueba_tcs/config/app/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppDatasource datasource;
  AppRepositoryImpl({required this.datasource});
  @override
  Stream<User?> authStatus() {
    return datasource.authStatus();
  }
}
