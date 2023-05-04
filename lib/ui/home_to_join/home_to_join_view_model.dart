import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'home_to_join_view_model.freezed.dart';

@Freezed(copyWith: false)
class HomeToJoinViewModel with _$HomeToJoinViewModel {
  const factory HomeToJoinViewModel({
    required Command onJoin,
  }) = _HomeToJoinViewModel;
}
