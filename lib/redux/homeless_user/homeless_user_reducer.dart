import 'package:nestify/redux/homeless_user/homeless_user_action.dart';
import 'package:nestify/redux/homeless_user/homeless_user_state.dart';
import 'package:redux/redux.dart';

final homelessUserStateReducer = combineReducers<HomelessUserState>([
  TypedReducer(_onCreateHome),
  TypedReducer(_createdHomeDraft),
  TypedReducer(_failedToCreateHomeDraft),
  TypedReducer(_errorProcessed),
]);

HomelessUserState _onCreateHome(
  HomelessUserState state,
  CreateHomeDraftAction action,
) {
  return state.copyWith(
    isLoading: true,
  );
}

HomelessUserState _createdHomeDraft(
  HomelessUserState state,
  CreatedHomeDraftAction action,
) {
  return state.copyWith(
    isLoading: false,
  );
}

HomelessUserState _failedToCreateHomeDraft(
  HomelessUserState state,
  FailedToOpenCreateHomeAction action,
) {
  return state.copyWith(
    isLoading: false,
    error: const HomelessUserError.failedToCreateHomeDraft(),
  );
}

HomelessUserState _errorProcessed(
  HomelessUserState state,
  HomelessUserErrorProcessedAction action,
) {
  return state.copyWith(
    error: null,
  );
}
