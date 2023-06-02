import 'package:nestify/service/external_activities_service/external_activities_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalActivitiesServiceImplementation
    implements ExternalActivitiesService {
  @override
  Future<void> mainTo(String email) async {
    final mailToUrl = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(mailToUrl)) {
      await launchUrl(mailToUrl);
    }
  }

  @override
  Future<void> shareHomeInvite({
    required String inviteDescription,
    required XFile qrCode,
  }) async {
    await Share.shareXFiles([qrCode], text: inviteDescription);
  }
}
