import 'package:freezed_annotation/freezed_annotation.dart';

part 'nestify_user.freezed.dart';

part 'nestify_user.g.dart';

@freezed
class NestifyUser with _$NestifyUser {
  const factory NestifyUser({
    required String id,
    required String userName,
    required String homeId,
    required String colorId,
    required String bio,
    required String? avatarUrl,
  }) = _NestifyUser;

  factory NestifyUser.fromJson(Map<String, dynamic> json) =>
      _$NestifyUserFromJson(json);
}
