import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_profile_state.freezed.dart';

@freezed
class CreateUserProfileState with _$CreateUserProfileState {
  const factory CreateUserProfileState({
    required File? avatar,
    required String name,
    required String bio,
    required bool isLoading,
    required CreateUserProfileError? error,
  }) = _CreateUserProfileState;

  factory CreateUserProfileState.initial() => const CreateUserProfileState(
        avatar: null,
        name: '',
        bio: '',
        isLoading: false,
        error: null,
      );
}

@freezed
class CreateUserProfileError with _$CreateUserProfileError {
  const factory CreateUserProfileError.failedToObtainPhoto() = _FailedToObrainPhoto;

  const factory CreateUserProfileError.failedToCreate() = _FailedToCreate;
}
