import 'package:nestify/service/dto/user_profile_dto.dart';

abstract class UserService {
  bool isLoggedIn();

  Future<String?> homeId();

  Future<UserProfileDto?> userProfile();

  Future<String> logInWithGoogle();

  Future<void> logOut();
}
