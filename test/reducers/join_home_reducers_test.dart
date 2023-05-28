import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  group('Join home reducers test', () {
    late Store<AppState> store;

    const homeToJoin = Home(
      id: 'id',
      homeName: 'homeName',
      adminId: 'adminId',
      usersIds: ['usersIds'],
      address: 'address',
      about: 'about',
      avatarUrl: 'avatarUrl',
    );

    final colorsList = [
      const UserColor(
        id: 'id',
        ru: 'ru',
        en: 'en',
        hex: 'hex',
      ),
    ];
    final homeUsers = [
      const User(
        id: 'userId',
        userName: 'userName',
        homeId: 'homeId',
        colorId: 'colorId',
        bio: 'bio',
        avatarUrl: 'avatarUrl',
      ),
    ];

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
    });

    test(
        'on initialize join home loading is set to true and error is reset to null',
        () {
      store.dispatch(InitJoinHomeAction(homeToJoin: homeToJoin));

      expect(
        store.state.joinHomeState.isLoading,
        true,
      );
      expect(store.state.homeState.error, null);
    });

    test('''on initialize join home failed 
      loading is set to false and set correct error''', () {
      store.dispatch(FailedToInitJoinHomeAction());

      expect(
        store.state.joinHomeState.isLoading,
        false,
      );
      expect(
        store.state.joinHomeState.error,
        const JoinHomeError.failedToInitJoinHome(),
      );
    });

    test('''on initialize join home success 
      loading is set to false and error is null and all loaded data set correctly''',
        () {
      ///Set error and loading values to ensure that reducer resets them
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial().copyWith(
          joinHomeState: store.state.joinHomeState.copyWith(
            error: const JoinHomeError.failedToInitJoinHome(),
            isLoading: true,
          ),
        ),
      );

      store.dispatch(JoinHomeInitializedAction(
        colors: colorsList,
        users: homeUsers,
      ));

      expect(
        store.state.joinHomeState.isLoading,
        false,
      );
      expect(store.state.joinHomeState.error, null);
      expect(
        store.state.joinHomeState.homeUsers,
        homeUsers,
      );
      expect(store.state.joinHomeState.colors, colorsList);
    });

    test('''on change step action step changed''', () {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
      );

      expect(store.state.joinHomeState.joinHomeStep, JoinHomeStep.homeInfo);

      store.dispatch(JoinHomeChangeStepAction(JoinHomeStep.userProfile));

      expect(store.state.joinHomeState.joinHomeStep, JoinHomeStep.userProfile);
    });

    test('''on join home loading is true and error is null''', () {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
      );

      store.dispatch(JoinHomeAction());

      expect(store.state.joinHomeState.isLoading, true);
      expect(store.state.joinHomeState.error, null);
    });
  });
}
