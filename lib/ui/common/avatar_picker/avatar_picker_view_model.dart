import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'avatar_picker_view_model.freezed.dart';

@Freezed(copyWith: false)
class AvatarPickerViewModel with _$AvatarPickerViewModel {
  const factory AvatarPickerViewModel.url({
    required String picture,
    required Command onClick,
  }) = _UrlAvatarPickerViewModel;

  const factory AvatarPickerViewModel.file({
    required File? picture,
    required Command? onClick,
  }) = _FileAvatarPickerViewModel;
}
