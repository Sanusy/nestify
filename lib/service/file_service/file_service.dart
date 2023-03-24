import 'dart:io';

abstract class FileService {
  Future<File?> pictureFromGallery();

  Future<String> uploadHomeAvatar(
    String homeId,
    File avatar,
  );
}
