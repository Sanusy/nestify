import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_profile_state.freezed.dart';

@freezed
class HomeProfileState with _$HomeProfileState {
  const factory HomeProfileState({
    required bool isLoading,
  }) = _HomeProfileState;

  factory HomeProfileState.initial() => const HomeProfileState(
        isLoading: false,
      );
}
