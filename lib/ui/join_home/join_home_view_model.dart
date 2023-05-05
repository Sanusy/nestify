import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'join_home_view_model.freezed.dart';

@Freezed(copyWith: false)
class JoinHomeViewModel with _$JoinHomeViewModel {
  const factory JoinHomeViewModel({
    required Command onJoin,
  }) = _JoinHomeViewModel;
}
