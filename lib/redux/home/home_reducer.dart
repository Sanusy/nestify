import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:redux/redux.dart';

final homeStateReducer = combineReducers<HomeState>([
  TypedReducer(_initHome),
  TypedReducer(_failedToInitHome),
  TypedReducer(_homeInitialized),
  TypedReducer(_homeDeleted),
]);

HomeState _initHome(HomeState state, InitHomeAction action) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

HomeState _failedToInitHome(HomeState state, FailedToInitHomeAction action) {
  return state.copyWith(
    isLoading: false,
    error: const HomeError.failedToInitHome(),
  );
}

HomeState _homeInitialized(HomeState state, HomeInitializedAction action) {
  return state.copyWith(
    colors: action.colors,
    currentUserId: action.currentUserId,
    home: action.home,
    homeUsers: action.users,
    isLoading: false,
    error: null,
  );
}

HomeState _homeDeleted(HomeState state, HomeDeletedAction action) {
  return HomeState.initial();
}
