import 'package:go_router/go_router.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/nestify_go_route.dart';
import 'package:nestify/ui/first_screen/first_screen.dart';
import 'package:nestify/ui/second_screen/second_screen.dart';
import 'package:nestify/ui/third_screen/third_screen.dart';

final goRouter = GoRouter(
  routes: [
    NestifyGoRoute(
      path: const AppRoute.first().routeName,
      child: const FirstScreen(),
      fullscreenDialog: const AppRoute.third().fullscreenDialog,
      routes: [
        NestifyGoRoute(
          path: const AppRoute.second().routeName,
          child: const SecondScreen(),
          fullscreenDialog: const AppRoute.third().fullscreenDialog,
          routes: [
            NestifyGoRoute(
              path: const AppRoute.third().routeName,
              child: const ThirdScreen(),
              fullscreenDialog: const AppRoute.third().fullscreenDialog,
            ),
          ],
        ),
      ],
    ),
  ],
);

extension on AppRoute {
  String get routeName => when(
        first: () => '/',
        second: () => 'second',
        third: () => 'third',
      );
}
