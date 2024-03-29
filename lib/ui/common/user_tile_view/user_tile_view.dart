import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/network_circle_avatar.dart';
import 'package:nestify/ui/common/user_tile_view/user_tile_view_model.dart';

class UserTileView extends StatelessWidget {
  final UserTileViewModel viewModel;

  const UserTileView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return ListTile(
      onTap: viewModel.onOpenUser,
      leading: NetworkCircleAvatar(
        radius: 20,
        avatarUrl: viewModel.userPictureUrl,
        placeholder: Text(
          viewModel.userName.characters.first.toUpperCase(),
          style:
              theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor),
        ),
      ),
      title: Text(viewModel.userName),
      trailing: viewModel.isAdmin
          ? Text(
              localization.homeProfileAdminMember,
              style: theme.textTheme.labelSmall,
            )
          : null,
    );
  }
}
