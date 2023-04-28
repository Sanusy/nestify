import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/add_member/add_member_state.dart';
import 'package:redux/redux.dart';

final addMemberStateReducer = combineReducers<AddMemberState>([
  TypedReducer(_obtainInviteUrl),
  TypedReducer(_inviteUrlObtained),
  TypedReducer(_failedToObtainInviteUrl),
  TypedReducer(_createInvitePicture),
  TypedReducer(_shareInviteAction),
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

AddMemberState _inviteUrlObtained(
  AddMemberState state,
  InviteUrlObtainedAction action,
) {
  return state.copyWith(
    isLoading: false,
    error: null,
    inviteUrl: action.inviteUrl,
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

AddMemberState _createInvitePicture(
  AddMemberState state,
  CreateInvitePictureAction action,
) {
  return state.copyWith(
    isInviteCapturingInProgress: true,
  );
}

AddMemberState _shareInviteAction(
  AddMemberState state,
  ShareInviteAction action,
) {
  return state.copyWith(
    isInviteCapturingInProgress: false,
  );
}
