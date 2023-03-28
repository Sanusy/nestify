import 'dart:io';

class PickCreateUserProfileAvatarAction {}

class CreateUserProfileAvatarPickedAction {
  final File avatar;

  CreateUserProfileAvatarPickedAction(this.avatar);
}

class FailedToPickCreateUserProfileAvatarAction {}

class RemoveCreateUserProfileAvatarAction {}

class UserNameChangedAction {
  final String newName;

  UserNameChangedAction(this.newName);
}

class BioChangedAction {
  final String newBio;

  BioChangedAction(this.newBio);
}

class CreateUserProfileErrorProcessedAction {}
