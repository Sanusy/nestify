import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_color.freezed.dart';

part 'user_color.g.dart';

@freezed
class UserColor with _$UserColor {
  const UserColor._();

  const factory UserColor({
    required String id,
    required String ru,
    required String en,
    required String hex,
  }) = _UserColor;

  Color get toColor => Color(int.parse(hex, radix: 16) + 0xFF000000);

  factory UserColor.fromJson(Map<String, dynamic> json) =>
      _$UserColorFromJson(json);
}
