import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/models/home.dart';

part 'edit_home_state.freezed.dart';

@freezed
class EditHomeState with _$EditHomeState {
  const EditHomeState._();

  const factory EditHomeState({
    required bool isLoading,
    required Home? initialHome,
    required Home? editedHome,
    required File? pickedAvatar,
  }) = _EditHomeState;

  bool get hasChanges => editedHome != initialHome || pickedAvatar != null;

  bool get canEditHome => editedHome?.homeName.isNotEmpty == true;

  factory EditHomeState.initial() => const EditHomeState(
        isLoading: true,
        initialHome: null,
        editedHome: null,
        pickedAvatar: null,
      );
}
