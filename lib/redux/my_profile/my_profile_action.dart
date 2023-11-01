import 'dart:io';

import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';

class InitMyProfileAction {
  final User myProfile;

  InitMyProfileAction(this.myProfile);
}

class CloseMyProfileAction {}

class MyProfilePickAvatarAction {}

class MyProfileAvatarPickedAction {
  final File pickedAvatar;

  MyProfileAvatarPickedAction(this.pickedAvatar);
}

class RemoveMyProfileAvatarAction {}

class MyProfileNameChangedAction {
  final String newName;

  MyProfileNameChangedAction(this.newName);
}

class MyProfileBioChangedAction {
  final String newBio;

  MyProfileBioChangedAction(this.newBio);
}

class MyProfileColorChangedAction {
  final UserColor newColor;

  MyProfileColorChangedAction(this.newColor);
}

class EditMyProfileAction {}

class MyProfileEditedAction {
  final User editedUser;

  MyProfileEditedAction(this.editedUser);
}

class FailedToEditMyProfileAction {}
