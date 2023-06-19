import 'package:nestify/redux/edit_home/edit_home_action.dart';
import 'package:nestify/redux/edit_home/edit_home_state.dart';
import 'package:redux/redux.dart';

final editHomeStateReducer = combineReducers<EditHomeState>([
  TypedReducer(_initEditHome),
  TypedReducer(_closeEditHome),
  TypedReducer(_pickedHomeAvatar),
  TypedReducer(_removeHomeAvatar),
  TypedReducer(_homeNameChanged),
  TypedReducer(_homeAddressChanged),
  TypedReducer(_homeAboutChanged),
]);

EditHomeState _initEditHome(
  EditHomeState state,
  InitEditHomeAction action,
) {
  return state.copyWith(
    initialHome: action.homeToEdit,
    editedHome: action.homeToEdit,
    isLoading: false,
  );
}

EditHomeState _closeEditHome(
  EditHomeState state,
  CloseEditHomeAction action,
) {
  return EditHomeState.initial();
}

EditHomeState _pickedHomeAvatar(
  EditHomeState state,
  EditHomeAvatarPickedAction action,
) {
  return state.copyWith(
    pickedAvatar: action.pickedAvatar,
  );
}

EditHomeState _removeHomeAvatar(
  EditHomeState state,
  RemoveEditHomeAvatarAction action,
) {
  return state.copyWith(
    editedHome: state.editedHome?.copyWith(
      avatarUrl: null,
    ),
    pickedAvatar: null,
  );
}

EditHomeState _homeNameChanged(
  EditHomeState state,
  EditHomeNameChangedAction action,
) {
  return state.copyWith(
    editedHome: state.editedHome?.copyWith(
      homeName: action.newName,
    ),
  );
}

EditHomeState _homeAddressChanged(
  EditHomeState state,
  EditHomeAddressChangedAction action,
) {
  return state.copyWith(
    editedHome: state.editedHome?.copyWith(
      address: action.newAddress,
    ),
  );
}

EditHomeState _homeAboutChanged(
  EditHomeState state,
  EditHomeAboutChangedAction action,
) {
  return state.copyWith(
    editedHome: state.editedHome?.copyWith(
      about: action.newAbout,
    ),
  );
}
