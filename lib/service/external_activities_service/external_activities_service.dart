import 'package:image_picker/image_picker.dart';

abstract class ExternalActivitiesService {
  Future<void> mainTo(String email);

  Future<void> shareHomeInvite({
    required String inviteDescription,
    required XFile qrCode,
  });
}
