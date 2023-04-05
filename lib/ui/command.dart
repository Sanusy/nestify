import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/ui/common/quit_confirmation_dialog/quit_confirmation_dialog_view_model.dart';
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
      dispatch(action(T));
    });
  }

  /// Will be used in flow where you need either close dialog or pop the whole screen
  QuitConfirmationDialogViewModel get baseQuitConfirmationViewModel =>
      QuitConfirmationDialogViewModel(
        onQuit: Command(() {
          dispatch(const NavigationAction.pop());
          dispatch(const NavigationAction.pop());
        }),
        onStay: createCommand(const NavigationAction.pop()),
      );
}
