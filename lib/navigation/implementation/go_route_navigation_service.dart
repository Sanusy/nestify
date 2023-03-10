import 'package:go_router/go_router.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/navigation_service.dart';

class GoRouteNavigationService implements NavigationService {
  final GoRouter _router;

  const GoRouteNavigationService(this._router);

  @override
  void pop() {
    _router.pop();
  }

  @override
  void push(AppRoute routeToPush) {
    _router.push(routeToPush.routePath);
  }

  @override
  void replace(AppRoute newRoute) {
    _router.pushReplacement(newRoute.routePath);
  }

  @override
  void setPath(AppRoute finalRoute) {
    _router.go(finalRoute.routePath);
  }
}

extension on AppRoute {
  String get routePath => when(
        first: () => '/',
        second: () => '/second',
        third: () => '/second/third',
      );
}
