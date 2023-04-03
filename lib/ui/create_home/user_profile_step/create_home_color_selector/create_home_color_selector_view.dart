import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/create_home/user_profile_step/create_home_color_selector/create_home_color_selector_view_model.dart';

class CreateHomeColorSelectorView extends StatelessWidget {
  final CreateHomeColorSelectorViewModel viewModel;

  const CreateHomeColorSelectorView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return viewModel.when(
      loading: () => const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (onRetry) => Column(
        children: [
          Text(localization.commonError),
          TextButton(
            onPressed: onRetry,
            child: Text(
              localization.commonRetry,
            ),
          )
        ],
      ),
      loaded: (colors) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            localization.createHomeUserProfileSelectColorTitle,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            localization.createHomeUserProfileSelectColorDescription,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 2,
            runSpacing: 2,
            children: colors
                .map((colorViewModel) => _ColorItem(
                      viewModel: colorViewModel,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  final ColorViewModel viewModel;

  const _ColorItem({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemSize = (MediaQuery.of(context).size.width - 32) / 6.1;

    return Container(
      width: itemSize,
      height: itemSize,
      color: viewModel.color,
      child: GestureDetector(
        onTap: viewModel.onSelect?.command,
        child: viewModel.onSelect == null
            ? const Icon(
                Icons.done,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
