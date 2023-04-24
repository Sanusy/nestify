import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/add_member/add_member_state.dart';
import 'package:redux/redux.dart';

final addMemberStateReducer = combineReducers<AddMemberState>([
  TypedReducer(_errorProcessed),
]);

AddMemberState _errorProcessed(
  AddMemberState state,
  AddMemberErrorProcessedAction action,
) {
  return state.copyWith(
    error: null,
  );
}
