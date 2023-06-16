import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/edit_home/edit_home_view_model.dart';

class EditHomeScreen extends StatelessWidget {
  final EditHomeViewModel viewModel;

  const EditHomeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.editHomeTitle),
        actions: viewModel.mapOrNull(
          loaded: (viewModel) => [
            if (viewModel.onEdit != null)
              TextButton(
                onPressed: viewModel.onEdit?.command,
                child: Text(localization.editHomeSave),
              ),
          ],
        ),
      ),
      body: viewModel.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (loadedViewModel) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: AvatarPicker(
                  viewModel: loadedViewModel.homeAvatarViewModel,
                  backgroundIcon: Icons.home_outlined,
                ),
              ),
              const SizedBox(height: 32),
              NestifyTextField(
                viewModel: loadedViewModel.homeNameViewModel,
                label: localization.editHomeHomeName,
              ),
              const SizedBox(height: 32),
              NestifyTextField(
                viewModel: loadedViewModel.homeAddressViewModel,
                label: localization.editHomeAddress,
              ),
              const SizedBox(height: 32),
              NestifyMultilineTextField(
                viewModel: loadedViewModel.homeAboutViewModel,
                label: localization.editHomeAbout,
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
