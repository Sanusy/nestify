import 'package:flutter/material.dart';
import 'package:nestify/ui/command.dart';

mixin PopupMixin {
  void showSnackBar(
    BuildContext context,
    String content,
    Command? onProcessed,
  ) {
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(SnackBar(content: Text(content)));
    onProcessed?.command();
  }
}
