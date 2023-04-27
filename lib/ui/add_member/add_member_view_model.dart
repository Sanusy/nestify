import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'add_member_view_model.freezed.dart';

@Freezed(copyWith: false)
class AddMemberViewModel with _$AddMemberViewModel {
  const factory AddMemberViewModel.loading() = _Loading;

  const factory AddMemberViewModel.failed({
    required Command onRetry,
  }) = _Failed;

  const factory AddMemberViewModel.loaded({
    required String inviteUrl,
    required Command onShareUrl,
  }) = _Loaded;
}
