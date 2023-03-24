import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_home_state.freezed.dart';

@freezed
class CreateHomeState with _$CreateHomeState {
  const factory CreateHomeState({
    required File? avatar,
    required String homeName,
    required String homeAddress,
    required String about,
    required bool isLoading,
    required CreateHomeError? error,
  }) = _CreateHomeState;

  factory CreateHomeState.initial() => const CreateHomeState(
        avatar: null,
        homeName: '',
        homeAddress: '',
        about: '',
        isLoading: false,
        error: null,
      );
}

@freezed
class CreateHomeError with _$CreateHomeError {
  const factory CreateHomeError.failedToObtainPhoto() = _FailedToObrainPhoto;

  const factory CreateHomeError.failedToCreate() = _FailedToCreate;
}
