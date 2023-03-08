import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({required int stub}) = _AppState;

  factory AppState.initial() => const AppState(
        stub: 0,
      );
}
