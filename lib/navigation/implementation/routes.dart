import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/nestify_go_route.dart';
import 'package:nestify/service/dto/home_dto.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:nestify/ui/homeless_user/homeless_user_connector.dart';
import 'package:nestify/ui/login/login_connector.dart';
import 'package:nestify/ui/root_tab_bar/root_tab_bar_screen.dart';

final goRouter = GoRouter(
  initialLocation: const AppRoute.rootTebBar().routeName,
  routes: [
    NestifyGoRoute(
      path: const AppRoute.rootTebBar().routeName,
      child: const RootTabBarScreen(),
      fullscreenDialog: const AppRoute.rootTebBar().fullscreenDialog,
      redirect: (_, __) async {
        final userService = GetIt.instance.get<UserService>();
        final homeService = GetIt.instance.get<HomeService>();

        if (!userService.isLoggedIn()) {
          return const AppRoute.login().routePath;
        }

        final isHomeMember = (await userService.homeId()) != null;

        if (!isHomeMember) {
          return const AppRoute.homelessUser().routePath;
        }

        final home = await homeService.userHome();

        if (home.homeStatus == HomeStatus.draft) {
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
  ],
);

extension AppRouteExtensionForGoRouter on AppRoute {
  String get routeName => when(
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        rootTebBar: () => '/rootTabBar',
      );

  String get routePath => when(
        login: () => '/login',
        homelessUser: () => '/homelessUser',
        rootTebBar: () => '/rootTabBar',
      );
}
