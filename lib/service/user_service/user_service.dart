abstract class UserService {
  String? currentUserId();

  Future<String> logInWithGoogle();
}
