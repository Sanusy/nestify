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
}