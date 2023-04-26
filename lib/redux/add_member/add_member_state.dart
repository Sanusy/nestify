import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_member_state.freezed.dart';

@freezed
class AddMemberState with _$AddMemberState {
  const factory AddMemberState({
    required String? inviteUrl,
    required bool isLoading,
    required AddMemberError? error,
  }) = _AddMemberState;

  factory AddMemberState.initial() => const AddMemberState(
        inviteUrl: null,
        isLoading: false,
        error: null,
      );
}

@freezed
class AddMemberError with _$AddMemberError {
  const factory AddMemberError.obtainInviteUrl() = _ObtainInviteUrlError;
}
