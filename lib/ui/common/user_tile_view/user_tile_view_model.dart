import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'user_tile_view_model.freezed.dart';

@Freezed(copyWith: false)
class UserTileViewModel with _$UserTileViewModel {
  const factory UserTileViewModel({
    required String? userPictureUrl,
    required String userName,
    required bool isAdmin,
    required Command onOpenUser,
  }) = _UserTileViewModel;
}
