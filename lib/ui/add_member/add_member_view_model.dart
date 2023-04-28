import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'add_member_view_model.freezed.dart';

@Freezed(copyWith: false)
class AddMemberViewModel with _$AddMemberViewModel {
  const factory AddMemberViewModel.loading() = _Loading;

  const factory AddMemberViewModel.failed({
    required Command onRetry,
  }) = _Failed;

  const factory AddMemberViewModel.loaded({
    required bool isInviteCapturingInProgress,
    required HomeInviteViewModel homeInviteViewModel,
    required Command onCreatePictureInvite,
    required CommandWith<Uint8List> onShareInvite,
  }) = _Loaded;
}

@Freezed(copyWith: false)
class HomeInviteViewModel with _$HomeInviteViewModel {
  const factory HomeInviteViewModel({
    required String homeName,
    required String? homeAddress,
    required String? humeAvatarUrl,
    required String inviteUrl,
  }) = _HomeInviteViewModel;
}
