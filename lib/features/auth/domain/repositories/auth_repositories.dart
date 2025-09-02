abstract class AuthRepositories {
  Future<void> createUser(String email, String password);
  Future<void> loginUser(String email, String password);
}
