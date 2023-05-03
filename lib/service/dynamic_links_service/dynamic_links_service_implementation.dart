import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:nestify/models/dynamic_links_data.dart';
import 'package:nestify/service/dynamic_links_service/dynamic_links_service.dart';
import 'package:nestify/service/network_error.dart';

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

      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse("https://nestify.home.invite/$homeId"),
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

      await homeDoc.update({'inviteUrl': generatedUrl});

      return generatedUrl;
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<String?> initialLink() async {
    final initialLink = await _dynamicLinks.getInitialLink();
    return initialLink?.link.toString();
  }

  @override
  Stream<String> dynamicLinks() {
    return _dynamicLinks.onLink
        .map((pendingLink) => pendingLink.link.toString());
  }
}
