import 'dart:async';

import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

class InitHomeMiddleware extends BaseMiddleware<InitHomeAction> {
  final HomeService _homeService;
  final UserService _userService;

  StreamSubscription<Home>? _homeStreamSubscription;
  StreamSubscription<List<User>>? _usersStreamSubscription;

  InitHomeMiddleware(
    this._homeService,
    this._userService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    InitHomeAction action,
  ) async {
    try {
      final currentUserId = _userService.currentUserId();

      if (currentUserId == null) {
        store.dispatch(const NavigationAction.setPath(AppRoute.login()));
        return;
      }

      final userHomeId = await _userService.homeId();

      if (userHomeId == null) {
        store.dispatch(const NavigationAction.setPath(AppRoute.homelessUser()));
        return;
      }

      final colors = await _homeService.availableColors();

      final homeUpdatesStream = _homeService.watchHome(userHomeId);

      final home = await homeUpdatesStream.first;

      final usersUpdatesStream = _homeService.watchHomeUsers(home.usersUrls);

      final users = await usersUpdatesStream.first;

      store.dispatch(HomeInitializedAction(
        currentUserId: currentUserId,
        colors: colors,
        home: home,
        users: users,
      ));

      _homeStreamSubscription?.cancel();
      _homeStreamSubscription = homeUpdatesStream.skip(1).listen((home) {
        store.dispatch(HomeUpdatedAction(home));

        _usersStreamSubscription?.cancel();
        _usersStreamSubscription = usersUpdatesStream.skip(1).listen((users) {
          store.dispatch(HomeUsersUpdatedAction(users));
        });
      });
    } on NetworkError {
      store.dispatch(FailedToInitHomeAction());
    }
  }
}
