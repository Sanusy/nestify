import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';

class FileServiceImplementation implements FileService {
  final _imagePicker = ImagePicker();

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
}
