import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/login/view/login_button_view_model.dart';

part 'login_view_model.freezed.dart';

@Freezed(copyWith: false)
class LoginViewModel with _$LoginViewModel {
  const factory LoginViewModel({
    required LoginButtonViewModel googleLoginViewModel,
    required bool isFailed,
  }) = _LoginViewModel;
}
