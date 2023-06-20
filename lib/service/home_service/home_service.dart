import 'dart:io';

import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';

abstract interface class HomeService {
  Future<List<UserColor>> availableColors();

  Future<void> createHome({
    required HomeProfileDraftState homeDraft,
    required UserProfileDraftState userDraft,
  });

  Future<void> joinHome({
    required String homeId,
    required UserProfileDraftState userDraft,
  });

  Future<void> deleteHome({required Home homeToDelete});

  Future<Home> home(String homeId);

  Future<Home?> homeByInviteUrl(String inviteUrl);

  Future<List<User>> homeUsers(List<String> userIds);

  Future<void> leaveHome({
    required String homeId,
    String? newAdminId,
  });

  Future<Home> editHome({
    required Home homeToEdit,
    File? newAvatar,
  });
}
