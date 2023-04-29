import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/dynamic_links_service/dynamic_links_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

class ObtainInviteUrlMiddleware extends BaseMiddleware<ObtainInviteUrlAction> {
  final DynamicLinkService _dynamicLinkService;

  ObtainInviteUrlMiddleware(
    this._dynamicLinkService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    ObtainInviteUrlAction action,
  ) async {
    try {
      final homeState = store.state.homeState;

      if (homeState.home == null) {
        store.dispatch(const NavigationAction.setPath(AppRoute.homelessUser()));
      }

      final inviteUrl =
          await _dynamicLinkService.homeInviteUrl(homeState.home!.id);

      store.dispatch(InviteUrlObtainedAction(inviteUrl: inviteUrl));
    } on NetworkError {
      store.dispatch(FailedToObtainInviteUrlAction());
    }
  }
}
