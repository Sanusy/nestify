import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/navigation/app_route.dart';

part 'navigation_action.freezed.dart';

@freezed
abstract class NavigationAction with _$NavigationAction {
  const factory NavigationAction.push(AppRoute route) = PushNavigationAction;

  const factory NavigationAction.replace(AppRoute route) =
      ReplaceNavigationAction;

  const factory NavigationAction.setPath(AppRoute route) =
      SetPathNavigationAction;

  const factory NavigationAction.pop() = PopNavigationAction;
}
