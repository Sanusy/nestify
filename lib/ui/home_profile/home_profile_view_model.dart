import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/user_tile_view/user_tile_view_model.dart';

part 'home_profile_view_model.freezed.dart';

@Freezed(copyWith: false)
class HomeProfileViewModel with _$HomeProfileViewModel {
  const factory HomeProfileViewModel.loading() = _Loading;

  const factory HomeProfileViewModel.failed({
    required Command onRetry,
  }) = _Failed;

  const factory HomeProfileViewModel.loaded({
    required Command? onDeleteHome,
    required String? pictureUrl,
    required String homeName,
    required String? homeAddress,
    required String? about,
    required String membersDescription,
    required Command? onAddMember,
    required List<UserTileViewModel> users,
  }) = HomeProfileLoadedViewModel;
}
