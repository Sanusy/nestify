import 'package:nestify/core/app_configuration.dart';

Future<void> main() async {
  await AppConfiguration(environment: Environment.dev).run();
}
