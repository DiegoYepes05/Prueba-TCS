abstract class AuthDatasource {
  Future createUser(String email, String password);
  Future loginUser(String email, String password);
}
