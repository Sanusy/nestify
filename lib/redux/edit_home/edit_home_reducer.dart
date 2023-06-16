import 'package:nestify/redux/edit_home/edit_home_action.dart';
import 'package:nestify/redux/edit_home/edit_home_state.dart';
import 'package:redux/redux.dart';

final editHomeStateReducer = combineReducers<EditHomeState>([
  TypedReducer(_initHome),
  TypedReducer(_pickedHomeAvatar),
]);

EditHomeState _initHome(EditHomeState state, InitEditHomeAction action) {
  return state.copyWith(
    initialHome: action.homeToEdit,
    editedHome: action.homeToEdit,
    isLoading: false,
  );
}

EditHomeState _pickedHomeAvatar(
  EditHomeState state,
  EditHomeAvatarPickedAction action,
) {
  return state.copyWith(
    pickedAvatar: action.pickedAvatar,
  );
}
