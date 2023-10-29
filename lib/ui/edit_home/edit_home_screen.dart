import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/edit_home/components/edit_home_body_view.dart';
import 'package:nestify/ui/edit_home/edit_home_view_model.dart';

final class EditHomeScreen extends StatelessWidget with PopupMixin {
  final EditHomeViewModel viewModel;

  const EditHomeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async {
        return viewModel.map(
          loading: (_) => true,
          loaded: (loadedViewModel) {
            if (loadedViewModel.quitConfirmation != null) {
              showQuitConfirmationDialog(
                  context, loadedViewModel.quitConfirmation!);
              return false;
            }
            return true;
          },
        );
      },
      child: Scaffold(
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
          loaded: (loadedViewModel) => EditHomeBodyView(
            viewModel: loadedViewModel,
          ),
        ),
      ),
    );
  }
}
