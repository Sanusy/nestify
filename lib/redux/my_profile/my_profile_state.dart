import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/models/nestify_user.dart';

part 'my_profile_state.freezed.dart';

@freezed
class MyProfileState with _$MyProfileState {
  const MyProfileState._();

  const factory MyProfileState({
    required bool isLoading,
    required NestifyUser? initialProfile,
    required NestifyUser? editedProfile,
    required File? pickedAvatar,
  }) = _MyProfileState;

  bool get hasChanges =>
      editedProfile != initialProfile || pickedAvatar != null;

  bool get canEditMyProfile => editedProfile?.userName.isNotEmpty == true;

  factory MyProfileState.initial() => const MyProfileState(
        isLoading: true,
        initialProfile: null,
        editedProfile: null,
        pickedAvatar: null,
      );
}
