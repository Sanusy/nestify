import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'home_view_model.freezed.dart';

@Freezed(copyWith: false)
class HomeViewModel with _$HomeViewModel {
  const factory HomeViewModel({
    required Command onLogout,
  }) = _HomeViewModel;
}
