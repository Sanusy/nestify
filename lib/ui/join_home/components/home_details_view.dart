import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/network_circle_avatar.dart';
import 'package:nestify/ui/common/user_tile_view/user_tile_view.dart';
import 'package:nestify/ui/join_home/join_home_view_model.dart';

class HomeToJoinDetailsView extends StatelessWidget {
  final JoinHomeDetailsViewModel viewModel;

  const HomeToJoinDetailsView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 16,
                ),
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
                  localization.joinHomeMembers,
                  style: theme.textTheme.labelLarge,
                ),
                ...viewModel.users.map((user) => UserTileView(viewModel: user)),
                const Spacer(),
                OutlinedButton(
                  onPressed: viewModel.onNext,
                  child: Text(localization.joinHomeCreateProfile),
                ),
              ]
                  .map((widget) => widget is UserTileView || widget is Spacer
                      ? widget
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: widget,
                        ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
