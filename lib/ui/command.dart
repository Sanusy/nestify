import 'package:nestify/redux/app_state.dart';
import 'package:redux/redux.dart';

class Command {
  final void Function() command;

  Command(this.command);

  void call() {
    command.call();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Command && runtimeType == other.runtimeType;

  @override
  int get hashCode => command.hashCode;

  static Command stub = Command(() {});
}

extension StoreCommandExtension on Store<AppState> {
  Command createCommand(dynamic action) {
    return Command(() {
      dispatch(action);
    });
  }
}
