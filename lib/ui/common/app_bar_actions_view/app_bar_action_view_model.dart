import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'app_bar_action_view_model.freezed.dart';

@Freezed(copyWith: false)
class AppBarActionViewModel with _$AppBarActionViewModel {
  const factory AppBarActionViewModel({
    required Command onClick,
    required String title,
    IconData? icon,
    @Default(false) bool isDestructive,
  }) = _AppBarActionViewModel;
}
