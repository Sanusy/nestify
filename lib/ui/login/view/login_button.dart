import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nestify/gen/assets.gen.dart';
import 'package:nestify/ui/login/view/login_button_view_model.dart';

class LoginButton extends StatelessWidget {
  final LoginButtonViewModel viewModel;

  const LoginButton({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: viewModel.mapOrNull(
          available: (available) => available.onLogin?.command,
        ),
        child: viewModel.map(
          loading: (_) => const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          available: (available) => Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  Assets.images.login.googleLogo,
                  width: 32,
                  height: 32,
                ),
              ),
              Text(available.title),
            ],
          ),
        ),
      ),
    );
  }
}
