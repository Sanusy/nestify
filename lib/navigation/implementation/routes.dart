import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/nestify_go_route.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_connector.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_destinations.dart';
import 'package:nestify/ui/create_home/create_home_connector.dart';
import 'package:nestify/ui/home/home_connector.dart';
import 'package:nestify/ui/home_profile/home_profile_screen.dart';
import 'package:nestify/ui/homeless_user/homeless_user_connector.dart';
import 'package:nestify/ui/login/login_connector.dart';
import 'package:nestify/ui/settings/settings_screen.dart';

/// Used to open screen above BottomNavigation ShellRoute
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: const AppRoute.login().routeName,
  routes: [
    ShellRoute(
      builder: (_, state, currentScreen) {
        return BottomNavigationConnector(
          currentDestination: _bottomNavigationDestination(),
          currentScreen: currentScreen,
        );
      },
      routes: [
        NestifyGoRoute(
          path: const AppRoute.home().routeName,
          child: const HomeConnector(),
          fullscreenDialog: const AppRoute.home().fullscreenDialog,
        ),
        NestifyGoRoute(
          path: const AppRoute.homeProfile().routeName,
          child: const HomeProfileScreen(),
          fullscreenDialog: const AppRoute.homeProfile().fullscreenDialog,
        ),
        NestifyGoRoute(
          path: const AppRoute.settings().routeName,
          child: const SettingsScreen(),
          fullscreenDialog: const AppRoute.settings().fullscreenDialog,
        ),
      ],
    ),
    NestifyGoRoute(
      path: const AppRoute.login().routeName,
      child: const LoginConnector(),
      fullscreenDialog: const AppRoute.login().fullscreenDialog,
      redirect: (_, __) async {
        final userService = GetIt.instance.get<UserService>();

        if (userService.currentUserId() == null) {
          return null;
        }

        final isHomeMember = (await userService.homeId()) != null;

        if (isHomeMember) {
          return const AppRoute.home().routePath;
        }

        return const AppRoute.homelessUser().routePath;
      },
    ),
    NestifyGoRoute(
      path: const AppRoute.homelessUser().routeName,
      child: const HomelessUserConnector(),
      fullscreenDialog: const AppRoute.homelessUser().fullscreenDialog,
      redirect: (_, __) async {
        final userService = GetIt.instance.get<UserService>();

        if (userService.currentUserId() == null) {
          return const AppRoute.login().routePath;
        }

        final isHomeMember = (await userService.homeId()) != null;

        if (isHomeMember) {
          return const AppRoute.home().routePath;
        }

        return null;
      },
    ),
    NestifyGoRoute(
      path: const AppRoute.createHome().routeName,
      child: const CreateHomeConnector(),
      fullscreenDialog: const AppRoute.createHome().fullscreenDialog,
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

extension AppRouteExtensionForGoRouter on AppRoute {
  /// Used in GoRouter to give a route it's path. if it is a one of the
  /// root routes, should start with '/'. If route is nested inside another
  /// route, should only contain route name without '/'.
  ///
  /// For example if you have root route Home, and nested in Home TaskDetails route,\
  /// Home route name should be '/home', and TaskDetails should be 'taskDetails.
  String get routeName => when(
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        createHome: () => '/createHome',
        home: () => '/home',
        homeProfile: () => '/homeProfile',
        settings: () => '/settings',
      );

  /// Used in navigation service to provide full path to the destination
  /// should provide full path from the very first parent route separated with '/'
  /// for example if Home route contains nested route TaskDetails,
  /// path to taskDetails should be /home/taskDetails
  String get routePath => when(
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        createHome: () => '/createHome',
        home: () => '/home',
        homeProfile: () => '/homeProfile',
        settings: () => '/settings',
      );
}
