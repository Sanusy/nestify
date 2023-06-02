import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/color_selector/color_selector_item_view_model.dart';

part 'create_home_color_selector_view_model.freezed.dart';

@Freezed(copyWith: false)
class CreateHomeColorSelectorViewModel with _$CreateHomeColorSelectorViewModel {
  const factory CreateHomeColorSelectorViewModel.loading() = _Loading;

  const factory CreateHomeColorSelectorViewModel.error({
    required Command onRetry,
  }) = _Error;

  const factory CreateHomeColorSelectorViewModel.loaded({
    required List<ColorSelectorItemViewModel> availableColors,
  }) = _Loaded;
}
