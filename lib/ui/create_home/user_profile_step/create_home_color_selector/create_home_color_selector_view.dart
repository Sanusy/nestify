import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/color_selector/color_selector_view.dart';
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
      loaded: (colors) => ColorSelectorView(colors: colors),
    );
  }
}
