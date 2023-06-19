import 'dart:io';

import 'package:nestify/models/home.dart';

class InitEditHomeAction {
  final Home homeToEdit;

  InitEditHomeAction(this.homeToEdit);
}

class EditHomePickHomeAvatarAction {}

class EditHomeAvatarPickedAction {
  final File pickedAvatar;

  EditHomeAvatarPickedAction(this.pickedAvatar);
}

class RemoveEditHomeAvatarAction {}

class EditHomeNameChangedAction {
  final String newName;

  EditHomeNameChangedAction(this.newName);
}

class EditHomeAddressChangedAction {
  final String newAddress;

  EditHomeAddressChangedAction(this.newAddress);
}

class EditHomeAboutChangedAction {
  final String newAbout;

  EditHomeAboutChangedAction(this.newAbout);
}
