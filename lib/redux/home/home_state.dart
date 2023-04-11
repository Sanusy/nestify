import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    required bool isLoading,
    required HomeError? error,
    required Home? home,
    required List<User> homeUsers,
    required User? currentUser,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
        isLoading: false,
        error: null,
        home: null,
        homeUsers: [],
        currentUser: null,
      );
}

@freezed
class HomeError with _$HomeError {
  const factory HomeError.failedToInitHome() = _FailedToInitHome;
}
