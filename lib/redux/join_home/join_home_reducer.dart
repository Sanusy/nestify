import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';
import 'package:redux/redux.dart';

final joinHomeStateReducer = combineReducers<JoinHomeState>([
  TypedReducer(_initJoinHome),
  TypedReducer(_joinHomeInitialized),
  TypedReducer(_failedToInitJoinHome),
  TypedReducer(_changeStepAction),
  TypedReducer(_pickedUserAvatar),
  TypedReducer(_removeUserAvatar),
  TypedReducer(_userNameChanged),
  TypedReducer(_userBioChanged),
  TypedReducer(_colorSelected),
  TypedReducer(_joinHome),
  TypedReducer(_failedToJoinHome),
  TypedReducer(_resetJoinHomeState),
]);

JoinHomeState _initJoinHome(
  JoinHomeState state,
  InitJoinHomeAction action,
) {
  return state.copyWith(
    homeToJoin: action.homeToJoin,
    isLoading: true,
    error: null,
  );
}

JoinHomeState _joinHomeInitialized(
  JoinHomeState state,
  JoinHomeInitializedAction action,
) {
  return state.copyWith(
    homeUsers: action.users,
    colors: action.colors,
    isLoading: false,
    error: null,
  );
}

JoinHomeState _failedToInitJoinHome(
  JoinHomeState state,
  FailedToInitJoinHomeAction action,
) {
  return state.copyWith(
    isLoading: false,
    error: const JoinHomeError.failedToInitJoinHome(),
  );
}

JoinHomeState _changeStepAction(
  JoinHomeState state,
  JoinHomeChangeStepAction action,
) {
  return state.copyWith(
    joinHomeStep: action.step,
  );
}

JoinHomeState _pickedUserAvatar(
  JoinHomeState state,
  JoinHomeUserAvatarPickedAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userAvatar: action.avatar,
    ),
  );
}

JoinHomeState _removeUserAvatar(
  JoinHomeState state,
  JoinHomeRemoveUserAvatarAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userAvatar: null,
    ),
  );
}

JoinHomeState _userNameChanged(
  JoinHomeState state,
  JoinHomeUserNameChangedAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userName: action.newName,
    ),
  );
}

JoinHomeState _userBioChanged(
  JoinHomeState state,
  JoinHomeUserBioChangedAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userBio: action.newBio,
    ),
  );
}

JoinHomeState _colorSelected(
  JoinHomeState state,
  JoinHomeColorSelectedAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      selectedColor: action.color,
    ),
  );
}

JoinHomeState _joinHome(
  JoinHomeState state,
  JoinHomeAction action,
) {
  return state.copyWith(
    isJoinInProgress: true,
    error: null,
  );
}

JoinHomeState _failedToJoinHome(
  JoinHomeState state,
  FailedToJoinHomeAction action,
) {
  return state.copyWith(
    isJoinInProgress: false,
  );
}

JoinHomeState _resetJoinHomeState(
  JoinHomeState state,
  ResetJoinHomeStateAction action,
) {
  return JoinHomeState.initial();
}
