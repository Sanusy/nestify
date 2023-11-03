import 'package:nestify/navigation/app_route.dart';

extension AppRouteExtensionForGoRouter on AppRoute {
  /// Used in GoRouter to give a route it's path. if it is a one of the
  /// root routes, should start with '/'. If route is nested inside another
  /// route, should only contain route name without '/'.
  ///
  /// For example if you have root route Home, and nested in Home TaskDetails route,\
  /// Home route name should be '/home', and TaskDetails should be 'taskDetails.
  String get routeName => switch (this) {
        SplashRoute _ => '/',
        LoginRoute _ => '/login',
        HomelessUserRoute _ => '/homelessUser',
        CreateHomeRoute _ => '/createHome',
        HomeRoute _ => '/home',
        HomeProfileRoute _ => '/homeProfile',
        SettingsRoute _ => '/settings',
        AddMemberRoute _ => 'addMember',
        JoinHomeRoute _ => 'joinHome',
        ScanQrCodeRoute _ => 'scanQrCode',
        EditHomeRoute _ => 'editHome',
        MyProfileRoute _ => 'myProfile',
      };

  /// Used in navigation service to provide full path to the destination
  /// should provide full path from the very first parent route separated with '/'
  /// for example if Home route contains nested route TaskDetails,
  /// path to taskDetails should be /home/taskDetails
  String get routePath => switch (this) {
        SplashRoute _ => '/',
        LoginRoute _ => '/login',
        HomelessUserRoute _ => '/homelessUser',
        CreateHomeRoute _ => '/createHome',
        HomeRoute _ => '/home',
        HomeProfileRoute _ => '/homeProfile',
        SettingsRoute _ => '/settings',
        AddMemberRoute _ => '/homeProfile/$routeName',
        JoinHomeRoute _ => '/homelessUser/$routeName',
        ScanQrCodeRoute _ => '/homelessUser/$routeName',
        EditHomeRoute _ => '/homeProfile/$routeName',
        MyProfileRoute _ => '/settings/$routeName',
      };
}
