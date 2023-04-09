import 'package:flutter/material.dart';
import 'package:nestify/ui/command.dart';

class OutlinedIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Command? onClick;

  const OutlinedIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick?.command,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
