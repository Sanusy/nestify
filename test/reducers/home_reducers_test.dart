import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  group('Create home reducers test group', () {
    late Store<AppState> store;

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
    });

    test('on initialize home loading is set to true', () {
      store.dispatch(InitHomeAction());

      expect(
        store.state.homeState.isLoading,
        true,
      );
      expect(store.state.homeState.error, null);
    });

    test('''on initialize home failed 
      loading is set to false and set correct error''', () {
      store.dispatch(FailedToInitHomeAction());

      expect(
        store.state.homeState.isLoading,
        false,
      );
      expect(store.state.homeState.error, const HomeError.failedToInitHome());
    });

    test('''on initialize home success 
      loading is set to false and error is null and all loaded data set correctly''',
        () {
      ///Set error and loading values to ensure that reducer resets them
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial().copyWith(
          homeState: store.state.homeState.copyWith(
            error: const HomeError.failedToInitHome(),
            isLoading: true,
          ),
        ),
      );

      const homeId = 'homeId';
      const userId = 'userId';
      final availableColors = [
        const UserColor(id: 'id', ru: 'ru', en: 'en', hex: 'hex')
      ];
      const loadedHome = Home(
        id: homeId,
        homeName: 'homeName',
        adminId: userId,
        usersIds: [userId],
        address: 'address',
        about: 'about',
        avatarUrl: 'avatarUrl',
      );
      final loadedUsers = [
        const User(
          id: userId,
          userName: 'userName',
          homeId: homeId,
          colorId: 'colorId',
          bio: 'bio',
          avatarUrl: 'avatarUrl',
        ),
      ];
      store.dispatch(HomeInitializedAction(
        currentUserId: userId,
        colors: availableColors,
        home: loadedHome,
        users: loadedUsers,
      ));

      expect(
        store.state.homeState.isLoading,
        false,
      );
      expect(store.state.homeState.error, null);
      expect(
        store.state.homeState.homeUsers,
        loadedUsers,
      );
      expect(store.state.homeState.home, loadedHome);
      expect(
        store.state.homeState.colors,
        availableColors,
      );
      expect(store.state.homeState.currentUserId, userId);
    });
  });
}
