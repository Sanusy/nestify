import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/models/home_invite.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/app_route_extension.dart';
import 'package:nestify/navigation/implementation/nestify_go_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/dynamic_links/dynamic_links_action.dart';
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
import 'package:nestify/ui/home_to_join/home_to_join_connector.dart';
import 'package:nestify/ui/homeless_user/homeless_user_connector.dart';
import 'package:nestify/ui/login/login_connector.dart';
import 'package:nestify/ui/settings/settings_connector.dart';
import 'package:redux/redux.dart';

/// Used to open screen above BottomNavigation ShellRoute
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    NestifyGoRoute(
      appRoute: const AppRoute.splash(),
      child: Container(),
      redirect: (_, __) async {
        final serviceLocator = GetIt.instance;
        final userService = serviceLocator.get<UserService>();
        final homeService = serviceLocator.get<HomeService>();
        final snackBarService = serviceLocator.get<SnackBarService>();
        final store = serviceLocator.get<Store<AppState>>();

        if (userService.currentUserId() == null) {
          return const AppRoute.login().routePath;
        }

        store.dispatch(ListenDynamicLinksAction());

        final dynamicLinksService = serviceLocator.get<DynamicLinkService>();
        final initialDynamicLink = await dynamicLinksService.initialLink();

        final isHomeMember = (await userService.homeId()) != null;

        if (!isHomeMember && initialDynamicLink == null) {
          return const AppRoute.homelessUser().routePath;
        }

        if (!isHomeMember && initialDynamicLink != null) {
          final homeInvite = HomeInvite.fromJson(
            initialDynamicLink.queryParameters,
          );
          try {
            final home = await homeService.home(homeInvite.homeId);

            if (homeInvite.inviteId == home.inviteId) {
              return const AppRoute.homeToJoin().routePath;
            }
            snackBarService.showInvalidInviteError();
            return const AppRoute.homelessUser().routePath;
          } on NetworkError catch (_) {
            snackBarService.showJoinHomeError();
            return const AppRoute.homelessUser().routePath;
          }
        }

        if (isHomeMember && initialDynamicLink != null) {
          snackBarService.showAlreadyHomeMemberSnackBar();
        }

        return const AppRoute.home().routePath;
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
          appRoute: const AppRoute.home(),
          child: const HomeConnector(),
        ),
        NestifyGoRoute(
            appRoute: const AppRoute.homeProfile(),
            child: const HomeProfileConnector(),
            routes: [
              NestifyGoRoute(
                appRoute: const AppRoute.addMember(),
                child: const AddMemberConnector(),
              )
            ]),
        NestifyGoRoute(
          appRoute: const AppRoute.settings(),
          child: const SettingsConnector(),
        ),
      ],
    ),
    NestifyGoRoute(
      appRoute: const AppRoute.login(),
      child: const LoginConnector(),
    ),
    NestifyGoRoute(
        appRoute: const AppRoute.homelessUser(),
        child: const HomelessUserConnector(),
        routes: [
          NestifyGoRoute(
            appRoute: const AppRoute.homeToJoin(),
            child: const HomeToJoinConnector(),
          ),
        ]),
    NestifyGoRoute(
      appRoute: const AppRoute.createHome(),
      child: const CreateHomeConnector(),
    ),
  ],
);

BottomNavigationDestination _bottomNavigationDestination() {
  final location = goRouter.location;

  final homeProfileTabPath = const AppRoute.homeProfile().routePath;
  final settingsTabPath = const AppRoute.settings().routePath;

  if (location.startsWith(homeProfileTabPath)) {
    return BottomNavigationDestination.homeProfile;
  }
  if (location.startsWith(settingsTabPath)) {
    return BottomNavigationDestination.settings;
  }
  return BottomNavigationDestination.home;
}
