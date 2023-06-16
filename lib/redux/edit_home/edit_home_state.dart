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

  factory EditHomeState.initial() => const EditHomeState(
        isLoading: false,
        initialHome: null,
        editedHome: null,
        pickedAvatar: null,
      );
}
