import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/navigation/app_route.dart';

part 'navigation_action.freezed.dart';

@freezed
abstract class NavigationAction with _$NavigationAction {
  const factory NavigationAction.push(AppRoute route) = _PushNavigationAction;

  const factory NavigationAction.replace(AppRoute route) =
      _ReplaceNavigationAction;

  const factory NavigationAction.setPath(AppRoute route) =
      _SetPathNavigationAction;

  const factory NavigationAction.pop() = _PopNavigationAction;
}
