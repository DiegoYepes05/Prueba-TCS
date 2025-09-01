import 'package:prueba_tcs/features/auth/domain/datasources/auth_datasource.dart';
import 'package:prueba_tcs/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  final AuthDatasource datasource;

  AuthRepositoriesImpl({required this.datasource});

  @override
  Future createUser(String email, String password) {
    return datasource.createUser(email, password);
  }

  @override
  Future loginUser(String email, String password) {
    return datasource.loginUser(email, password);
  }
}
