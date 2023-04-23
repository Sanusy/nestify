import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/network_circle_avatar.dart';
import 'package:nestify/ui/home_profile/components/user_tile_view.dart';
import 'package:nestify/ui/home_profile/home_profile_view_model.dart';

class HomeProfileLoadedBodyView extends StatelessWidget {
  final HomeProfileLoadedViewModel viewModel;

  const HomeProfileLoadedBodyView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        NetworkCircleAvatar(
          radius: 90,
          placeholder: Icon(
            Icons.home_outlined,
            size: 120,
            color: theme.colorScheme.primary,
          ),
          avatarUrl: viewModel.pictureUrl,
        ),
        const SizedBox(height: 16),
        Text(
          viewModel.homeName,
          style: theme.textTheme.bodyLarge,
        ),
        if (viewModel.homeAddress != null)
          Text(
            viewModel.homeAddress!,
            style: theme.textTheme.bodyMedium,
          ),
        const SizedBox(height: 16),
        if (viewModel.about != null) ...[
          Text(
            viewModel.about!,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
        ],
        Text(
          localization.homeProfileMembers,
          style: theme.textTheme.labelLarge,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: viewModel.users.length,
          itemBuilder: (_, index) {
            return UserTileView(viewModel: viewModel.users[index]);
          },
        ),
      ]
          .map((widget) => widget is ListView
              ? widget
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: widget,
                ))
          .toList(),
    );
  }
}
