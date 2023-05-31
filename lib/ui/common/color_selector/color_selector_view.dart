import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/color_selector/color_item.dart';
import 'package:nestify/ui/common/color_selector/color_selector_item_view_model.dart';

class ColorSelectorView extends StatelessWidget {
  final List<ColorSelectorItemViewModel> colors;

  const ColorSelectorView({
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
          localization.colorSelectorTitle,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          localization.colorSelectorDescription,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 2,
          runSpacing: 2,
          children: colors
              .map((colorViewModel) => ColorSelectorItem(
                    viewModel: colorViewModel,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
