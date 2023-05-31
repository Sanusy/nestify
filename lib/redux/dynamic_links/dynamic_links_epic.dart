import 'dart:async';

import 'package:nestify/models/home_invite.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/dynamic_links/dynamic_links_action.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/dynamic_links_service/dynamic_links_service.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

final class DynamicLinksEpic implements EpicClass<AppState> {
  final DynamicLinkService _dynamicLinkService;
  final SnackBarService _snackBarService;
  final UserService _userService;
  final HomeService _homeService;

  DynamicLinksEpic(
    this._dynamicLinkService,
    this._snackBarService,
    this._userService,
    this._homeService,
  );

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<ListenDynamicLinksAction>().flatMap((action) {
      return _dynamicLinkService
          .dynamicLinks()
          .asyncMap((dynamicLink) async {
            if ((await _userService.homeId()) != null) {
              _snackBarService.showAlreadyHomeMemberSnackBar();
            } else {
              try {
                final homeInvite =
                    HomeInvite.fromJson(dynamicLink.queryParameters);
                final homeToJoin = await _homeService.home(homeInvite.homeId);

                if (homeInvite.inviteId == homeToJoin.inviteId) {
                  return homeToJoin;
                } else {
                  _snackBarService.showInvalidInviteError();
                }
              } on NetworkError catch (_) {
                _snackBarService.showJoinHomeError();
              }
            }
          })
          .expand((homeToJoin) => homeToJoin != null
              ? List.of([
                  InitJoinHomeAction(homeToJoin: homeToJoin),
                  SetPathNavigationAction(JoinHomeRoute()),
                ])
              : [])
          .takeUntil(actions.whereType<StopListenDynamicLinksAction>());
    });
  }
}
