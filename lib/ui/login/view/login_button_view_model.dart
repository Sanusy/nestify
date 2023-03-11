import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'login_button_view_model.freezed.dart';

@Freezed(copyWith: false)
abstract class LoginButtonViewModel with _$LoginButtonViewModel {
  const factory LoginButtonViewModel.loading() = _LoginButtonLoadingViewModel;

  const factory LoginButtonViewModel.available({
    required String title,
    required Command? onLogin,
  }) = _LoginButtonAvailableiewModel;
}
