import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'create_user_profile_view_model.freezed.dart';

@Freezed(copyWith: false)
class CreateUserProfileViewModel with _$CreateUserProfileViewModel {
  const factory CreateUserProfileViewModel({
    required Command onLogout,
  }) = _CreateUserProfileViewModel;
}
