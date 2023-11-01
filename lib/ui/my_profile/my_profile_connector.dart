import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/my_profile/my_profile_screen.dart';
import 'package:nestify/ui/my_profile/my_profile_view_model.dart';
import 'package:redux/redux.dart';

final class MyProfileConnector extends BaseConnector<MyProfileViewModel> {
  const MyProfileConnector({super.key});

  @override
  MyProfileViewModel convert(
    BuildContext context,
    Store<AppState> store,
  ) {
    final localization = AppLocalizations.of(context)!;

    return const MyProfileViewModel.loading();
  }

  @override
  Widget screen(MyProfileViewModel viewModel) =>
      MyProfileScreen(viewModel: viewModel);
}
