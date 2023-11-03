import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:nestify/service/file_error.dart';

mixin FirebaseFileMixin {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadPicture(String path, File picture) async {
    final storageRef = _storage.ref();

    final avatarRef = storageRef.child(path);

    try {
      final uploadedAvatar = await avatarRef.putFile(picture);

      return uploadedAvatar.ref.getDownloadURL();
    } on FirebaseException {
      throw const FileError.failedToUpload();
    }
  }
}