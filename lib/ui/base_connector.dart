import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:redux/redux.dart';

abstract base class BaseConnector<VM> extends StatelessWidget {
  const BaseConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VM>(
      distinct: true,
      onInit: onInit,
      onDispose: onDispose,
      builder: (_, viewModel) {
        return screen(viewModel);
      },
      converter: (store) => convert(context, store),
      onDidChange: (_, viewModel) => processEvent(context, viewModel),
    );
  }

  void onInit(Store<AppState> store) {}

  void onDispose(Store<AppState> store) {}

  VM convert(BuildContext context, Store<AppState> store);

  Widget screen(VM viewModel);

  void processEvent(BuildContext context, VM viewModel) {}
}
