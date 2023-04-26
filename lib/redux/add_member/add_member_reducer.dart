import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/add_member/add_member_state.dart';
import 'package:redux/redux.dart';

final addMemberStateReducer = combineReducers<AddMemberState>([
  TypedReducer(_obtainInviteUrl),
  TypedReducer(_failedToObtainInviteUrl),
  TypedReducer(_errorProcessed),
]);

AddMemberState _obtainInviteUrl(
  AddMemberState state,
  ObtainInviteUrlAction action,
) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

AddMemberState _failedToObtainInviteUrl(
  AddMemberState state,
  FailedToObtainInviteUrlAction action,
) {
  return state.copyWith(
    isLoading: false,
    error: const AddMemberError.obtainInviteUrl(),
  );
}

AddMemberState _errorProcessed(
  AddMemberState state,
  AddMemberErrorProcessedAction action,
) {
  return state.copyWith(
    error: null,
  );
}
