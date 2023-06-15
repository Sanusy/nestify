import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/models/user.dart';

part 'home_profile_state.freezed.dart';

@freezed
class HomeProfileState with _$HomeProfileState {
  const factory HomeProfileState({
    required bool isLoading,
    required LeaveHomeState? leaveHomeState,
  }) = _HomeProfileState;

  factory HomeProfileState.initial() => const HomeProfileState(
        isLoading: false,
        leaveHomeState: null,
      );
}

@freezed
class LeaveHomeState with _$LeaveHomeState {
  const factory LeaveHomeState({
    required User? newAdmin,
  }) = _LeaveHomeState;

  factory LeaveHomeState.initial() => const LeaveHomeState(
        newAdmin: null,
      );
}
