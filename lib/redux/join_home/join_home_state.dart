import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';

part 'join_home_state.freezed.dart';

@freezed
class JoinHomeState with _$JoinHomeState {
  const JoinHomeState._();

  const factory JoinHomeState({
    required JoinHomeStep joinHomeStep,
    required Home? homeToJoin,
    required List<User> homeUsers,
    required List<UserColor> colors,
    required UserProfileDraftState userProfileDraftState,
    required bool isLoading,
    required bool isJoinInProgress,
    required JoinHomeError? error,
  }) = _JoinHomeState;

  factory JoinHomeState.initial() => JoinHomeState(
        joinHomeStep: JoinHomeStep.homeInfo,
        homeToJoin: null,
        homeUsers: [],
        colors: [],
        userProfileDraftState: UserProfileDraftState.initial(),
        isLoading: false,
        isJoinInProgress: false,
        error: null,
      );

  bool get hasChanges =>
      userProfileDraftState != UserProfileDraftState.initial();

  bool get canCreateHome =>
      userProfileDraftState.userName.isNotEmpty &&
      userProfileDraftState.selectedColor != null &&
      !isLoading;
}

enum JoinHomeStep {
  homeInfo,
  userProfile,
}

@freezed
class JoinHomeError with _$JoinHomeError {
  const factory JoinHomeError.failedToInitJoinHome() = _FailedToInitJoinHome;

  const factory JoinHomeError.failedToJoinHome() = _FailedToJoinHome;
}
