import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'create_home_view_model.freezed.dart';

@Freezed(copyWith: false)
class CreateHomeViewModel with _$CreateHomeViewModel {
  const factory CreateHomeViewModel({
    required String homeName,
    required String address,
    required String about,
    required Command? onCreateHome,
    required bool isLoading,
    required CreateHomeEvent? event,
  }) = _CreateHomeViewModel;
}

@Freezed(copyWith: false)
class CreateHomeEvent with _$CreateHomeEvent {
  const factory CreateHomeEvent.failedToCreateHomeDraft({
    required Command onProcessed,
  }) = _CreateHomeEvent;
}
