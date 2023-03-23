import 'dart:io';

abstract class FileService {
  Future<File?> pictureFromGallery();
}