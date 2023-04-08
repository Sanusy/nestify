import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/nestify_go_route.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:nestify/ui/create_home/create_home_connector.dart';
import 'package:nestify/ui/homeless_user/homeless_user_connector.dart';
import 'package:nestify/ui/login/login_connector.dart';

final goRouter = GoRouter(
  initialLocation: const AppRoute.rootTebBar().routeName,
  routes: [
    NestifyGoRoute(
      path: const AppRoute.rootTebBar().routeName,
      child: const BottomNavigationScreen(),
      fullscreenDialog: const AppRoute.rootTebBar().fullscreenDialog,
      redirect: (_, __) async {
        final userService = GetIt.instance.get<UserService>();

        if (userService.currentUserId() == null) {
          return const AppRoute.login().routePath;
        }

        final isHomeMember = (await userService.homeId()) != null;

        if (!isHomeMember) {
          return const AppRoute.homelessUser().routePath;
        }

        return null;
      },
    ),
    NestifyGoRoute(
      path: const AppRoute.login().routeName,
      child: const LoginConnector(),
      fullscreenDialog: const AppRoute.login().fullscreenDialog,
    ),
    NestifyGoRoute(
      path: const AppRoute.homelessUser().routeName,
      child: const HomelessUserConnector(),
      fullscreenDialog: const AppRoute.homelessUser().fullscreenDialog,
    ),
    NestifyGoRoute(
      path: const AppRoute.createHome().routeName,
      child: const CreateHomeConnector(),
      fullscreenDialog: const AppRoute.createHome().fullscreenDialog,
    ),
  ],
);

extension AppRouteExtensionForGoRouter on AppRoute {
  String get routeName => when(
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        createHome: () => '/createHome',
        rootTebBar: () => '/rootTabBar',
      );

  String get routePath => when(
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        createHome: () => '/createHome',
        rootTebBar: () => '/rootTabBar',
      );
}
