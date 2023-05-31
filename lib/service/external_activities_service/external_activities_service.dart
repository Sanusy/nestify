import 'package:image_picker/image_picker.dart';

abstract interface class ExternalActivitiesService {
  Future<void> mainTo(String email);

  Future<void> shareHomeInvite({
    required String inviteDescription,
    required XFile qrCode,
  });
}
