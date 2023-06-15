import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/home_profile/home_profile_state.dart';
import 'package:redux/redux.dart';

final homeProfileStateReducer = combineReducers<HomeProfileState>([
  TypedReducer(_deleteHome),
  TypedReducer(_failedToDeleteHome),
  TypedReducer(_homeDeleted),
  TypedReducer(_leaveHome),
  TypedReducer(_failedToLeaveHome),
  TypedReducer(_selectNewAdmin),
  TypedReducer(_closeLeaveHome),
]);

HomeProfileState _deleteHome(
  HomeProfileState state,
  DeleteHomeAction action,
) {
  return state.copyWith(
    isLoading: true,
  );
}

HomeProfileState _failedToDeleteHome(
  HomeProfileState state,
  FailedToDeleteHomeAction action,
) {
  return state.copyWith(
    isLoading: false,
  );
}

HomeProfileState _homeDeleted(
  HomeProfileState state,
  LeavedHomeAction action,
) {
  return HomeProfileState.initial();
}

HomeProfileState _leaveHome(
  HomeProfileState state,
  LeaveHomeAction action,
) {
  return state.copyWith(
    isLoading: true,
  );
}

HomeProfileState _failedToLeaveHome(
  HomeProfileState state,
  FailedToLeaveHomeAction action,
) {
  return state.copyWith(
    isLoading: false,
  );
}

HomeProfileState _selectNewAdmin(
  HomeProfileState state,
  SelectNewAdminAction action,
) {
  return state.copyWith(
    leaveHomeState: LeaveHomeState(newAdmin: action.newAdmin),
  );
}

HomeProfileState _closeLeaveHome(
  HomeProfileState state,
  ClosedLeaveHomeDialogAction action,
) {
  return state.copyWith(leaveHomeState: null);
}
