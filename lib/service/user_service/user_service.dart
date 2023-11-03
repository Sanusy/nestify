import 'dart:io';

import 'package:nestify/models/nestify_user.dart';

abstract interface class UserService {
  String? currentUserId();

  Future<String?> homeId();

  Future<String> logInWithGoogle();

  Future<NestifyUser> editMyProfile({
    required NestifyUser updatedProfile,
    File? newAvatar,
  });

  Future<void> logOut();
}
