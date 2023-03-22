import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_dto.freezed.dart';
part 'home_dto.g.dart';

@freezed
class HomeDto with _$HomeDto {
  const factory HomeDto({
    required String id,
    required String adminId,
    required List<String> users,
    required HomeStatus homeStatus,
  }) = _HomeDto;

  factory HomeDto.fromJson(Map<String, dynamic> json) =>
      _$HomeDtoFromJson(json);
}

enum HomeStatus {
  draft,
  created,
}