import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:redux/redux.dart';

final homeStateReducer = combineReducers<HomeState>([
  TypedReducer(_initHome),
  TypedReducer(_failedToInitHome),
]);

HomeState _initHome(HomeState state, InitHomeAction action) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

HomeState _failedToInitHome(HomeState state, FailedToInitHome action) {
  return state.copyWith(
    isLoading: false,
    error: const HomeError.failedToInitHome(),
  );
}
