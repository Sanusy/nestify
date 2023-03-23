import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'avatar_picker_view_model.freezed.dart';

@Freezed(copyWith: false)
class AvatarPickerViewModel with _$AvatarPickerViewModel {
  const factory AvatarPickerViewModel({
    required File? picture,
    required Command onClick,
  }) = _AvatarPickerViewModel;
}
