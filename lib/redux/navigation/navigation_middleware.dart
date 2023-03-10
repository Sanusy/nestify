import 'package:nestify/navigation/navigation_service.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:redux/redux.dart';

class NavigationMiddleware extends TypedMiddleware<AppState, NavigationAction> {
  final NavigationService _navigationService;

  NavigationMiddleware(
    this._navigationService,
  ) : super((store, navigationAction, next) {
          navigationAction.when(
            push: (route) {
              _navigationService.push(route);
            },
            replace: (route) {
              _navigationService.replace(route);
            },
            setPath: (route) {
              _navigationService.setPath(route);
            },
            pop: () {
              _navigationService.pop();
            },
          );
        });
}
