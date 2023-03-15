abstract class UserService {
  String? currentUserId();

  Future<String?> userHomeId(String userId);

  Future<String> logInWithGoogle();

  Future<void> logOut();
}
