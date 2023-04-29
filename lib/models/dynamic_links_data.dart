import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_links_data.freezed.dart';

part 'dynamic_links_data.g.dart';

@freezed
class DynamicLinksData with _$DynamicLinksData {
  const factory DynamicLinksData({
    required String iOsBundleId,
    required String androidPackageName,
    required String urlPrefix,
  }) = _DynamicLinksData;

  factory DynamicLinksData.fromJson(Map<String, dynamic> json) =>
      _$DynamicLinksDataFromJson(json);
}
