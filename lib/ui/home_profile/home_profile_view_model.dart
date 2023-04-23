import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'home_profile_view_model.freezed.dart';

@Freezed(copyWith: false)
class HomeProfileViewModel with _$HomeProfileViewModel {
  const factory HomeProfileViewModel.loading() = _Loading;

  const factory HomeProfileViewModel.failed({
    required Command onRetry,
  }) = _Failed;

  const factory HomeProfileViewModel.loaded({
    required String? pictureUrl,
    required String homeName,
    required String? homeAddress,
    required String? about,
    required List<HomeUserViewModel> users,
  }) = _Loaded;
}

@Freezed(copyWith: false)
class HomeUserViewModel with _$HomeUserViewModel {
  const factory HomeUserViewModel({
    required String? userPictureUrl,
    required String userName,
    required bool isAdmin,
    required Command onOpenUser,
  }) = _HomeUserViewModel;
}
