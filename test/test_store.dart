import 'package:redux/redux.dart';

class TestStore<State> extends Store<State> {
  final List<dynamic> actionLog = [];
  TestStore(super.reducer, {required super.initialState, super.middleware});

  @override
  void dispatch(dynamic action) {
    actionLog.add(action);
    super.dispatch(action);
  }
}