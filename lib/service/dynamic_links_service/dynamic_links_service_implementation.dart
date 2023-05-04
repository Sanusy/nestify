import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:nestify/models/dynamic_links_data.dart';
import 'package:nestify/models/home_invite.dart';
import 'package:nestify/service/dynamic_links_service/dynamic_links_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:uuid/uuid.dart';

class DynamicLinkServiceImplementation implements DynamicLinkService {
  final _dynamicLinks = FirebaseDynamicLinks.instance;
  final _firestore = FirebaseFirestore.instance;

  final _homesCollectionId = 'Homes';
  final _dynamicLinksDocPath = 'Constants/DynamicLinks';

  @override
  Future<String> homeInviteUrl(String homeId) async {
    try {
      final homeDoc = _firestore.collection(_homesCollectionId).doc(homeId);

      final inviteUrl = await homeDoc
          .get()
          .then((homeSnapshot) => homeSnapshot.data()!['inviteUrl']);

      if (inviteUrl != null) return inviteUrl;

      final constantsDoc = await _firestore.doc(_dynamicLinksDocPath).get();
      final dynamicLinksData = DynamicLinksData.fromJson(constantsDoc.data()!);

      final homeInvite = HomeInvite(
        homeId: homeId,
        inviteId: const Uuid().v1(),
      );

      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri(
          scheme: "https",
          host: 'nestify.home.invite',
          queryParameters: homeInvite.toJson(),
        ),
        uriPrefix: dynamicLinksData.urlPrefix,
        androidParameters:
            AndroidParameters(packageName: dynamicLinksData.androidPackageName),
        iosParameters: IOSParameters(bundleId: dynamicLinksData.iOsBundleId),
      );

      final generatedUrl = await _dynamicLinks
          .buildShortLink(
            dynamicLinkParams,
            shortLinkType: ShortDynamicLinkType.unguessable,
          )
          .then((shortLink) => shortLink.shortUrl.toString());

      await homeDoc.update({
        'inviteUrl': generatedUrl,
        'inviteId': homeInvite.inviteId,
      });

      return generatedUrl;
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<Uri?> initialLink() async {
    final initialLink = await _dynamicLinks.getInitialLink();
    return initialLink?.link;
  }

  @override
  Stream<Uri> dynamicLinks() {
    return _dynamicLinks.onLink.map(
      (pendingLink) => pendingLink.link,
    );
  }
}
