import 'package:nestify/navigation/app_route.dart';

extension AppRouteExtensionForGoRouter on AppRoute {
  /// Used in GoRouter to give a route it's path. if it is a one of the
  /// root routes, should start with '/'. If route is nested inside another
  /// route, should only contain route name without '/'.
  ///
  /// For example if you have root route Home, and nested in Home TaskDetails route,\
  /// Home route name should be '/home', and TaskDetails should be 'taskDetails.
  String get routeName => when(
        splash: () => '/',
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        createHome: () => '/createHome',
        home: () => '/home',
        homeProfile: () => '/homeProfile',
        settings: () => '/settings',
        addMember: () => 'addMember',
        joinHome: () => 'joinHome',
      );

  /// Used in navigation service to provide full path to the destination
  /// should provide full path from the very first parent route separated with '/'
  /// for example if Home route contains nested route TaskDetails,
  /// path to taskDetails should be /home/taskDetails
  String get routePath => when(
        splash: () => '/',
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        createHome: () => '/createHome',
        home: () => '/home',
        homeProfile: () => '/homeProfile',
        settings: () => '/settings',
        addMember: () => '/homeProfile/$routeName',
        joinHome: () => '/homelessUser/$routeName',
      );
}
