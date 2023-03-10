import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestifyGoRoute extends GoRoute {
  NestifyGoRoute({
    required String path,
    required Widget child,
    required bool fullscreenDialog,
    List<GoRoute> routes = const [],
  }) : super(
          path: path,
          pageBuilder: (_, state) => MaterialPage(
            child: child,
            fullscreenDialog: fullscreenDialog,
          ),
          routes: routes,
        );

  NestifyGoRoute.builder({
    required String path,
    required Widget Function(GoRouterState state) builder,
    required bool fullscreenDialog,
    List<GoRoute> routes = const [],
  }) : super(
          path: path,
          pageBuilder: (_, state) => MaterialPage(
            child: builder(state),
            fullscreenDialog: fullscreenDialog,
          ),
          routes: routes,
        );
}
