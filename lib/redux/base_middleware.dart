import 'package:nestify/redux/app_state.dart';
import 'package:redux/redux.dart';

abstract class BaseMiddleware<Action> extends MiddlewareClass<AppState> {
  void process(Store<AppState> store, Action action);

  @override
  dynamic call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);
    if (action is Action) {
      process(store, action);
    }
  }
}
