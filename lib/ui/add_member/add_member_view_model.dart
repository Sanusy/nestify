import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_member_view_model.freezed.dart';

@Freezed(copyWith: false)
class AddMemberViewModel with _$AddMemberViewModel {
  const factory AddMemberViewModel.loading() = _Loading;
}
