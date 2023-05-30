import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/models/home_invite.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/app_route_extension.dart';
import 'package:nestify/navigation/implementation/nestify_go_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/dynamic_links/dynamic_links_action.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/service/dynamic_links_service/dynamic_links_service.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:nestify/ui/add_member/add_member_connector.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_connector.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_destinations.dart';
import 'package:nestify/ui/create_home/create_home_connector.dart';
import 'package:nestify/ui/home/home_connector.dart';
import 'package:nestify/ui/home_profile/home_profile_connector.dart';
import 'package:nestify/ui/homeless_user/homeless_user_connector.dart';
import 'package:nestify/ui/join_home/join_home_connector.dart';
import 'package:nestify/ui/login/login_connector.dart';
import 'package:nestify/ui/settings/settings_connector.dart';
import 'package:redux/redux.dart';

/// Used to open screen above BottomNavigation ShellRoute
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    NestifyGoRoute(
      appRoute: SplashRoute(),
      child: Container(),
      redirect: (_, __) async {
        final serviceLocator = GetIt.instance;
        final userService = serviceLocator.get<UserService>();
        final homeService = serviceLocator.get<HomeService>();
        final snackBarService = serviceLocator.get<SnackBarService>();
        final store = serviceLocator.get<Store<AppState>>();

        if (userService.currentUserId() == null) {
          return LoginRoute().routePath;
        }

        store.dispatch(ListenDynamicLinksAction());

        final dynamicLinksService = serviceLocator.get<DynamicLinkService>();
        final initialDynamicLink = await dynamicLinksService.initialLink();

        final isHomeMember = (await userService.homeId()) != null;

        if (!isHomeMember && initialDynamicLink == null) {
          return HomelessUserRoute().routePath;
        }

        if (!isHomeMember && initialDynamicLink != null) {
          final homeInvite = HomeInvite.fromJson(
            initialDynamicLink.queryParameters,
          );
          try {
            final home = await homeService.home(homeInvite.homeId);

            if (homeInvite.inviteId == home.inviteId) {
              store.dispatch(InitJoinHomeAction(homeToJoin: home));
              return JoinHomeRoute().routePath;
            }
            snackBarService.showInvalidInviteError();
            return HomelessUserRoute().routePath;
          } on NetworkError catch (_) {
            snackBarService.showJoinHomeError();
            return HomelessUserRoute().routePath;
          }
        }

        if (isHomeMember && initialDynamicLink != null) {
          snackBarService.showAlreadyHomeMemberSnackBar();
        }

        return HomeRoute().routePath;
      },
    ),
    ShellRoute(
      builder: (_, state, currentScreen) {
        return BottomNavigationConnector(
          currentDestination: _bottomNavigationDestination(),
          currentScreen: currentScreen,
        );
      },
      routes: [
        NestifyGoRoute(
          appRoute: HomeRoute(),
          child: const HomeConnector(),
        ),
        NestifyGoRoute(
            appRoute: HomeProfileRoute(),
            child: const HomeProfileConnector(),
            routes: [
              NestifyGoRoute(
                appRoute: AddMemberRoute(),
                child: const AddMemberConnector(),
              ),
            ]),
        NestifyGoRoute(
          appRoute: SettingsRoute(),
          child: const SettingsConnector(),
        ),
      ],
    ),
    NestifyGoRoute(
      appRoute: LoginRoute(),
      child: const LoginConnector(),
    ),
    NestifyGoRoute(
        appRoute: HomelessUserRoute(),
        child: const HomelessUserConnector(),
        routes: [
          NestifyGoRoute(
            appRoute: JoinHomeRoute(),
            child: const JoinHomeConnector(),
          ),
        ]),
    NestifyGoRoute(
      appRoute: CreateHomeRoute(),
      child: const CreateHomeConnector(),
    ),
  ],
);

BottomNavigationDestination _bottomNavigationDestination() {
  final location = goRouter.location;

  final homeProfileTabPath = HomeProfileRoute().routePath;
  final settingsTabPath = SettingsRoute().routePath;

  if (location.startsWith(homeProfileTabPath)) {
    return BottomNavigationDestination.homeProfile;
  }
  if (location.startsWith(settingsTabPath)) {
    return BottomNavigationDestination.settings;
  }
  return BottomNavigationDestination.home;
}
