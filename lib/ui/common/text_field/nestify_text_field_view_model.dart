import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'nestify_text_field_view_model.freezed.dart';

@Freezed(copyWith: false)
class NestifyTextFieldViewModel with _$NestifyTextFieldViewModel {
  const factory NestifyTextFieldViewModel({
    required String text,
    required CommandWith<String>? onTextChanged,
    String? errorText,
  }) = _NestifyTextFieldViewModel;
}
