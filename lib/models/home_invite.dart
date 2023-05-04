import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_invite.freezed.dart';

part 'home_invite.g.dart';

@freezed
class HomeInvite with _$HomeInvite {
  const factory HomeInvite({
    required String inviteId,
    required String homeId,
  }) = _HomeInvite;

  factory HomeInvite.fromJson(Map<String, dynamic> json) => _$HomeInviteFromJson(json);
}
