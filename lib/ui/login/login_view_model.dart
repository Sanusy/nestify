import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'login_view_model.freezed.dart';

@Freezed(copyWith: false)
abstract class LoginViewModel with _$LoginViewModel{
  const factory LoginViewModel({
    Command? onLogInWithGoogle,
  }) = _LoginViewModel;
}