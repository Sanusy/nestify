import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'color_selector_item_view_model.freezed.dart';

@Freezed(copyWith: false)
class ColorSelectorItemViewModel with _$ColorSelectorItemViewModel {
  const factory ColorSelectorItemViewModel({
    required Command? onSelect,
    required bool isEnabled,
    required Color color,
  }) = _ColorSelectorItemViewModel;

  static int colorSorting(
    ColorSelectorItemViewModel firstColor,
    ColorSelectorItemViewModel _,
  ) =>
      firstColor.isEnabled ? -1 : 1;
}
