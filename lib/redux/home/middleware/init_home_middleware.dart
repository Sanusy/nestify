import 'dart:async';

import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

final class InitHomeMiddleware extends BaseMiddleware<InitHomeAction> {
  final HomeService _homeService;
  final UserService _userService;

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
        store.dispatch(SetPathNavigationAction(LoginRoute()));
        return;
      }

      final userHomeId = await _userService.homeId();

      if (userHomeId == null) {
        store.dispatch(SetPathNavigationAction(HomelessUserRoute()));
        return;
      }

      final colors = await _homeService.availableColors();
      final home = await _homeService.home(userHomeId);
      final users = await _homeService.homeUsers(home.usersIds);

      store.dispatch(HomeInitializedAction(
        currentUserId: currentUserId,
        colors: colors,
        home: home,
        users: users,
      ));
    } on NetworkError {
      store.dispatch(FailedToInitHomeAction());
    }
  }
}
