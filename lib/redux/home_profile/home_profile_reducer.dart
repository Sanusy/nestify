import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/home_profile/home_profile_state.dart';
import 'package:redux/redux.dart';

final homeProfileStateReducer = combineReducers<HomeProfileState>([
  TypedReducer(_deleteHome),
  TypedReducer(_failedToDeleteHome),
  TypedReducer(_homeDeleted),
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
  HomeDeletedAction action,
) {
  return HomeProfileState.initial();
}
