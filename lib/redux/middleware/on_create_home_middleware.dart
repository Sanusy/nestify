import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/homeless_user/homeless_user_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

class OnCreateHomeMiddleware extends BaseMiddleware<OnCreateHomeAction> {
  final HomeService _homeService;

  OnCreateHomeMiddleware(
    this._homeService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    OnCreateHomeAction action,
  ) async {
    try {
      await _homeService.createHomeDraft();

      store.dispatch(CreatedHomeDraftAction());
      store.dispatch(const NavigationAction.replace(AppRoute.createHome()));
    } on NetworkError {
      store.dispatch(FailedToOpenCreateHomeAction());
    }
  }
}
