import 'package:nestify/models/user_color.dart';

abstract class HomeService {
  Future<List<UserColor>> availableColors();
}
