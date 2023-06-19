import 'package:freezed_annotation/freezed_annotation.dart';

part 'home.freezed.dart';

part 'home.g.dart';

@freezed
class Home with _$Home {
  const factory Home({
    required String id,
    required String homeName,
    required String adminId,
    required List<String> usersIds,
    required String address,
    required String about,
    required String? avatarUrl,
    String? inviteId,
  }) = _Home;

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}
