import 'package:nestify/navigation/navigation_service.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:redux/redux.dart';

class NavigationMiddleware extends TypedMiddleware<AppState, NavigationAction> {
  NavigationMiddleware(
    NavigationService navigationService,
  ) : super((store, navigationAction, next) {
          navigationAction.when(
            push: (route) {
              navigationService.push(route);
            },
            replace: (route) {
              navigationService.replace(route);
            },
            setPath: (route) {
              navigationService.setPath(route);
            },
            pop: () {
              navigationService.pop();
            },
          );
        });
}
