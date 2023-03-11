abstract class UserService {
  String? currentUserId();

  Future<String> logInWithGoogle();

  Future<void> logOut();
}
