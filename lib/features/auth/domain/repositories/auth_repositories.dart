abstract class AuthRepositories {
  Future createUser(String email, String password);
  Future loginUser(String email, String password);
}
