import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:redux/redux.dart';

final createHomeStateReducer = combineReducers<CreateHomeState>([
  TypedReducer(_homeNameChangedAction),
  TypedReducer(_homeAddressChangedAction),
  TypedReducer(_homeAboutChangedAction),
]);

CreateHomeState _homeNameChangedAction(
  CreateHomeState state,
  HomeNameChangedAction action,
) {
  return state.copyWith(homeName: action.newName);
}

CreateHomeState _homeAddressChangedAction(
  CreateHomeState state,
  HomeAddressChangedAction action,
) {
  return state.copyWith(homeAddress: action.newAddress);
}

CreateHomeState _homeAboutChangedAction(
  CreateHomeState state,
  HomeAboutChangedAction action,
) {
  return state.copyWith(about: action.newAbout);
}
