import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/implementation/app_route_extension.dart';

class NestifyGoRoute extends GoRoute {
  NestifyGoRoute({
    required AppRoute appRoute,
    required Widget child,
    List<GoRoute> routes = const [],
    GoRouterRedirect? redirect,
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) : super(
          path: appRoute.routeName,
          pageBuilder: (_, state) => MaterialPage(
            child: child,
            fullscreenDialog: appRoute.fullscreenDialog,
          ),
          routes: routes,
          redirect: redirect,
          parentNavigatorKey: parentNavigatorKey,
        );

  NestifyGoRoute.builder({
    required String path,
    required Widget Function(GoRouterState state) builder,
    required bool fullscreenDialog,
    List<GoRoute> routes = const [],
    GoRouterRedirect? redirect,
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) : super(
          path: path,
          pageBuilder: (_, state) => MaterialPage(
            child: builder(state),
            fullscreenDialog: fullscreenDialog,
          ),
          routes: routes,
          redirect: redirect,
          parentNavigatorKey: parentNavigatorKey,
        );
}
