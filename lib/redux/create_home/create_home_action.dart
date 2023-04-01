import 'dart:io';

import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';

class LoadAvailableColorsAction {}

class LoadedAvailableColorsAction {
  final List<UserColor> availableColors;

  LoadedAvailableColorsAction(this.availableColors);
}

class FailedToLoadAvailableColorsAction {}

class CreateHomeStepChangedAction {
  final CreateHomeStep step;

  CreateHomeStepChangedAction(this.step);
}

class CreateHomePickHomeAvatarAction {}

class CreateHomeAvatarPickedAction {
  final File avatar;

  CreateHomeAvatarPickedAction(this.avatar);
}

class CreateHomeFailedToPickAvatarAction {}

class RemoveCreateHomeAvatarAction {}

class CreateHomeNameChangedAction {
  final String newName;

  CreateHomeNameChangedAction(this.newName);
}

class CreateHomeAddressChangedAction {
  final String newAddress;

  CreateHomeAddressChangedAction(this.newAddress);
}

class CreateHomeAboutChangedAction {
  final String newAbout;

  CreateHomeAboutChangedAction(this.newAbout);
}

class CreateHomePickUserAvatarAction {}

class CreateHomeUserAvatarPickedAction {
  final File avatar;

  CreateHomeUserAvatarPickedAction(this.avatar);
}

class CreateHomeRemoveUserAvatarAction {}

class CreateHomeUserNameChangedAction {
  final String newName;

  CreateHomeUserNameChangedAction(this.newName);
}

class CreateHomeUserBioChangedAction {
  final String newBio;

  CreateHomeUserBioChangedAction(this.newBio);
}

class CreateHomeAction {}

class CloseCreateHomeAction {}

class FailedToCreateHomeAction {}

class CreateHomeErrorProcessedAction {}
