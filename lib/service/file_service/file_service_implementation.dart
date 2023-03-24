import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';

class FileServiceImplementation implements FileService {
  final _imagePicker = ImagePicker();
  final _storage = FirebaseStorage.instance;

  @override
  Future<File?> pictureFromGallery() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      return pickedImage == null ? null : File(pickedImage.path);
    } catch (_) {
      throw const FileError.failedToObtain();
    }
  }

  @override
  Future<String> uploadHomeAvatar(
    String homeId,
    File avatar,
  ) async {
    final storageRef = _storage.ref();

    final avatarRef = storageRef
        .child('Homes/$homeId/Avatar/Avatar_${DateTime.now().toString()}');

    try {
      final uploadedAvatar = await avatarRef.putFile(avatar);

      return uploadedAvatar.ref.getDownloadURL();
    } on FirebaseException catch (_) {
      throw const FileError.failedToUpload();
    }
  }
}
