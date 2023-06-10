import 'package:flutter/material.dart';
import 'package:nestify/ui/common/app_bar_actions_view/app_bar_action_view_model.dart';

class AppBarActionsView extends StatelessWidget {
  final List<AppBarActionViewModel> actions;

  const AppBarActionsView({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton(
      onSelected: (selectedAction) => selectedAction.onClick(),
      itemBuilder: (_) => actions
          .map(
            (action) => PopupMenuItem(
              value: action,
              child: Row(
                children: [
                  if (action.icon != null) ...[
                    Icon(
                      action.icon,
                      color:
                          action.isDestructive ? theme.colorScheme.error : null,
                    ),
                    const SizedBox(width: 8)
                  ],
                  Text(
                    action.title,
                    style: action.isDestructive
                        ? TextStyle(color: theme.colorScheme.error)
                        : null,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
