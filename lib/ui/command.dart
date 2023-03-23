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

class CommandWith<T> {
  final Function(T) command;

  CommandWith(this.command);

  void call(T arg) {
    command.call(arg);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CommandWith && runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => command.hashCode;
}

extension StoreCommandExtension on Store<AppState> {
  Command createCommand(dynamic action) {
    return Command(() {
      dispatch(action);
    });
  }

  CommandWith<T> createCommandWith<T>(dynamic Function(T) action) {
    return CommandWith((T) {
      return dispatch(action);
    });
  }
}
