import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/nestify_go_route.dart';
import 'package:nestify/ui/login/login_connector.dart';
import 'package:nestify/ui/root_tab_bar/root_tab_bar_screen.dart';

final goRouter = GoRouter(
  redirect: (_, __) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const AppRoute.login().routeName;
    }
    const AppRoute.rootTebBar().routeName;
  },
  routes: [
    NestifyGoRoute(
      path: const AppRoute.login().routeName,
      child: const LoginConnector(),
      fullscreenDialog: const AppRoute.login().fullscreenDialog,
    ),
    NestifyGoRoute(
      path: const AppRoute.rootTebBar().routeName,
      child: const RootTabBarScreen(),
      fullscreenDialog: const AppRoute.rootTebBar().fullscreenDialog,
    ),
  ],
);

extension on AppRoute {
  String get routeName => when(
        login: () => '/login',
        rootTebBar: () => '/rootTabBar',
      );
}
