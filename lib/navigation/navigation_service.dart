import 'package:nestify/navigation/app_route.dart';

abstract interface class NavigationService {
  void push(AppRoute routeToPush);

  void replace(AppRoute newRoute);

  void setPath(AppRoute finalRoute);

  void pop();
}
