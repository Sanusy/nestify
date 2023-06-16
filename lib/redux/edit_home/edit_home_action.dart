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
