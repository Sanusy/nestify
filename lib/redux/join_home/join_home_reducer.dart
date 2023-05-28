import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';
import 'package:redux/redux.dart';

final joinHomeStateReducer = combineReducers<JoinHomeState>([
  TypedReducer(_initJoinHome),
  TypedReducer(_joinHomeInitialized),
  TypedReducer(_failedToInitJoinHome),
  TypedReducer(_changeStepAction),
  TypedReducer(_joinHome),
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

JoinHomeState _joinHome(
  JoinHomeState state,
  JoinHomeAction action,
) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}
