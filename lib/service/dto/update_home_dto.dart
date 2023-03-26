import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/service/dto/home_dto.dart';

part 'update_home_dto.freezed.dart';

part 'update_home_dto.g.dart';

@freezed
class UpdateHomeDto with _$UpdateHomeDto {
  const factory UpdateHomeDto._({
    required HomeStatus homeStatus,
    required String name,
    String? address,
    String? about,
    String? avatarUrl,
  }) = _UpdateHomeDto;

  factory UpdateHomeDto({
    required String name,
    String? address,
    String? about,
    String? avatarUrl,
  }) =>
      UpdateHomeDto._(
        homeStatus: HomeStatus.created,
        name: name,
        address: address,
        about: about,
        avatarUrl: avatarUrl,
      );

  factory UpdateHomeDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateHomeDtoFromJson(json);
}