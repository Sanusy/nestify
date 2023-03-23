import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

class DiscardCreateHomeMiddleware
    extends BaseMiddleware<DiscardCreateHomeAction> {
  final HomeService _homeService;

  DiscardCreateHomeMiddleware(
    this._homeService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    DiscardCreateHomeAction action,
  ) async {
    try {
      await _homeService.discardCreateHome();
      store.dispatch(const NavigationAction.replace(AppRoute.homelessUser()));
    } on NetworkError {
      store.dispatch(FailedToDiscardCreateHome());
    }
  }
}
