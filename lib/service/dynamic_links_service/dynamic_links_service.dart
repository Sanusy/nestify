abstract interface class DynamicLinkService {
  Future<String> homeInviteUrl(String homeId);

  Future<Uri?> initialLink();

  Stream<Uri> dynamicLinks();
}
