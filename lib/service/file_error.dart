import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_error.freezed.dart';

@freezed
class FileError with _$FileError {
  const factory FileError.failedToUpload() = _FailedToUpload;

  const factory FileError.failedToObtain() = _FailedToObtain;
}
