import 'package:nestify/redux/home_to_join/home_to_join_action.dart';
import 'package:nestify/redux/home_to_join/home_to_join_state.dart';
import 'package:redux/redux.dart';

final homeToJoinStateReducer = combineReducers<HomeToJoinState>([
  TypedReducer(_joinHome),
]);

HomeToJoinState _joinHome(HomeToJoinState state, JoinHomeAction action) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}
