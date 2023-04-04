import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/models/user_color.dart';

part 'create_home_state.freezed.dart';

@freezed
class CreateHomeState with _$CreateHomeState {
  const factory CreateHomeState({
    required CreateHomeStep createHomeStep,
    required HomeProfileDraftState homeProfileDraftState,
    required UserProfileDraftState userProfileDraftState,
    required ColorsLoadingState colorsState,
    required bool isLoading,
    required CreateHomeError? error,
  }) = _CreateHomeState;

  factory CreateHomeState.initial() => CreateHomeState(
        createHomeStep: CreateHomeStep.homeProfile,
        homeProfileDraftState: HomeProfileDraftState.initial(),
        userProfileDraftState: UserProfileDraftState.initial(),
        colorsState: const ColorsLoadingState.loading(),
        isLoading: false,
        error: null,
      );
}

@freezed
class HomeProfileDraftState with _$HomeProfileDraftState {
  const factory HomeProfileDraftState({
    required File? homeAvatar,
    required String homeName,
    required String homeAddress,
    required String homeAbout,
  }) = _HomeProfileDraftState;

  factory HomeProfileDraftState.initial() => const HomeProfileDraftState(
        homeAvatar: null,
        homeName: '',
        homeAddress: '',
        homeAbout: '',
      );
}

@freezed
class UserProfileDraftState with _$UserProfileDraftState {
  const factory UserProfileDraftState({
    required File? userAvatar,
    required String userName,
    required String userBio,
    required UserColor? selectedColor,
  }) = _UserProfileDraftState;

  factory UserProfileDraftState.initial() => const UserProfileDraftState(
        userAvatar: null,
        userName: '',
        userBio: '',
        selectedColor: null,
      );
}

@freezed
class ColorsLoadingState with _$ColorsLoadingState {
  const factory ColorsLoadingState.loading() = _Loading;

  const factory ColorsLoadingState.error() = _Error;

  const factory ColorsLoadingState.loaded({
    required List<UserColor> availableColors,
  }) = _Loaded;
}

enum CreateHomeStep {
  homeProfile,
  userProfile,
}

@freezed
class CreateHomeError with _$CreateHomeError {
  const factory CreateHomeError.failedToObtainPhoto() = _FailedToObrainPhoto;

  const factory CreateHomeError.failedToCreate() = _FailedToCreate;
}
