abstract class UserService {
  String? currentUserId();

  Future<String?> homeId();

  Future<String> logInWithGoogle();

  Future<void> logOut();
}
