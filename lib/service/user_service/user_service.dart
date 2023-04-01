abstract class UserService {
  bool isLoggedIn();

  Future<String?> homeId();

  Future<String> logInWithGoogle();

  Future<void> logOut();
}
