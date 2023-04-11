import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

class InitHomeMiddleware extends BaseMiddleware<InitHomeAction> {
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
    try {} on NetworkError {
      store.dispatch(FailedToInitHome());
    }
  }
}
