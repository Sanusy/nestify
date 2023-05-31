import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';

abstract interface class HomeService {
  Future<List<UserColor>> availableColors();

  Future<void> createHome({
    required HomeProfileDraftState homeDraft,
    required UserProfileDraftState userDraft,
  });

  Future<Home> home(String homeId);

  Future<List<User>> homeUsers(List<String> userIds);
}
