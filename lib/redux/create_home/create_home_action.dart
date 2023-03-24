import 'dart:io';

class DiscardCreateHomeAction {}

class FailedToDiscardCreateHome {}

class PickCreateHomeAvatarAction {}

class CreateHomeAvatarPickedAction {
  final File avatar;

  CreateHomeAvatarPickedAction(this.avatar);
}

class FailedToPickCreateHomeAvatarAction {}

class RemoveCreateHomeAvatarAction {}

class HomeNameChangedAction {
  final String newName;

  HomeNameChangedAction(this.newName);
}

class HomeAddressChangedAction {
  final String newAddress;

  HomeAddressChangedAction(this.newAddress);
}

class HomeAboutChangedAction {
  final String newAbout;

  HomeAboutChangedAction(this.newAbout);
}

class CreateHomeAction {}

class HomeCreatedAction {}

class FailedToCreateHomeAction {}

class CreateHomeErrorProcessedAction {}
