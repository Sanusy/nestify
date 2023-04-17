import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';

abstract class HomeService {
  Future<List<UserColor>> availableColors();

  Future<void> createHome({
    required HomeProfileDraftState homeDraft,
    required UserProfileDraftState userDraft,
  });

  Stream<Home> watchHome(String homeId);

  Stream<List<User>> watchHomeUsers(List<String> userIds);
}
