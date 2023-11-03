import 'dart:io';

import 'package:nestify/models/home.dart';
import 'package:nestify/models/nestify_user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';

class InitJoinHomeAction {
  final Home homeToJoin;

  InitJoinHomeAction({required this.homeToJoin});
}

class JoinHomeInitializedAction {
  final List<UserColor> colors;
  final List<NestifyUser> users;

  JoinHomeInitializedAction({
    required this.colors,
    required this.users,
  });
}

class FailedToInitJoinHomeAction {}

class JoinHomeChangeStepAction {
  final JoinHomeStep step;

  JoinHomeChangeStepAction(this.step);
}

class JoinHomePickUserAvatarAction {}

class JoinHomeUserAvatarPickedAction {
  final File avatar;

  JoinHomeUserAvatarPickedAction(this.avatar);
}

class JoinHomeRemoveUserAvatarAction {}

class JoinHomeUserNameChangedAction {
  final String newName;

  JoinHomeUserNameChangedAction(this.newName);
}

class JoinHomeUserBioChangedAction {
  final String newBio;

  JoinHomeUserBioChangedAction(this.newBio);
}

class JoinHomeColorSelectedAction {
  final UserColor color;

  JoinHomeColorSelectedAction(this.color);
}

class JoinHomeAction {}

class FailedToJoinHomeAction {}

class ResetJoinHomeStateAction {}
