import 'dart:io';

abstract interface class FileService {
  Future<File?> pictureFromGallery();

  Future<void> removePicture(String pictureUrl);
}
