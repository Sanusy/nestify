import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/join_home/join_home_view_model.dart';

class JoinHomeUserColorSelector extends StatelessWidget {
  final List<ColorViewModel> colors;

  const JoinHomeUserColorSelector({
    Key? key,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
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
    final itemSize = (MediaQuery.sizeOf(context).width - 32) / 6.1;

    return Container(
      width: itemSize,
      height: itemSize,
      color: viewModel.color,
      child: GestureDetector(
        onTap: viewModel.onSelect?.command,
        child: viewModel.onSelect == null || !viewModel.isEnabled
            ? Icon(
                !viewModel.isEnabled ? Icons.lock_outline : Icons.done,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
