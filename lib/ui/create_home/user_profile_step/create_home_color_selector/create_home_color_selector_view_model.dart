import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'create_home_color_selector_view_model.freezed.dart';

@Freezed(copyWith: false)
class CreateHomeColorSelectorViewModel with _$CreateHomeColorSelectorViewModel {
  const factory CreateHomeColorSelectorViewModel.loading() = _Loading;

  const factory CreateHomeColorSelectorViewModel.error({
    required Command onRetry,
  }) = _Error;

  const factory CreateHomeColorSelectorViewModel.loaded({
    required List<ColorViewModel> availableColors,
  }) = _Loaded;
}

@Freezed(copyWith: false)
class ColorViewModel with _$ColorViewModel {
  const factory ColorViewModel({
    required Command? onSelect,
    required Color color,
  }) = _ColorViewModel;
}
