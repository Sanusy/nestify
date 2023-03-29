import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_color_dto.freezed.dart';

part 'user_color_dto.g.dart';

@freezed
class UserColorDto with _$UserColorDto {
  const factory UserColorDto({
    required Colors color,
    required String? userId,
  }) = _UserColorDto;

  factory UserColorDto.fromJson(Map<String, dynamic> json) =>
      _$UserColorDtoFromJson(json);
}

class UserColorDtoJsonConverter extends JsonConverter<UserColorDto, Map<String, dynamic>> {
  const UserColorDtoJsonConverter();

  @override
  UserColorDto fromJson(Map<String, dynamic> json) {
    return UserColorDto.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(UserColorDto object) {
    return object.toJson();
  }
}

// TODO: Transfer colors initialization to Cloud functions
enum Colors {
  yellow,
  blue,
  green,
  purple,
}
