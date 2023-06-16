import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'edit_home_view_model.freezed.dart';

@Freezed(copyWith: false)
class EditHomeViewModel with _$EditHomeViewModel {
  const factory EditHomeViewModel({
    required Command? onEdit,
  }) = _EditHomeViewModel;
}
