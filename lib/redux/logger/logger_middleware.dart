import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:redux/redux.dart';

class LoggerMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    debugPrint('🚀 Action: ${action.runtimeType.toString()}');
    next(action);
  }
}
