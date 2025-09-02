abstract class AuthDatasource {
  Future<void> createUser(String email, String password);
  Future<void> loginUser(String email, String password);
}
