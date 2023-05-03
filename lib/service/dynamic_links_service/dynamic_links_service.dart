abstract class DynamicLinkService {
  Future<String> homeInviteUrl(String homeId);

  Future<String?> initialLink();

  Stream<String> dynamicLinks();
}
