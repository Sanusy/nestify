import 'package:firebase_core/firebase_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_error.freezed.dart';

@freezed
class NetworkError with _$NetworkError {
  const factory NetworkError.unknown() = _NetworkUnknownError;

  const factory NetworkError.noInternet() = _NetworNoInternetError;

  const factory NetworkError.notAuthenticated() = _NetworkNotAuthenticatedError;
}

extension FirebaseExceptionExtension on FirebaseException {
  NetworkError toNetworkError() {
    return switch (code) {
      'permission-denied' ||
      'unauthenticated' =>
        const NetworkError.notAuthenticated(),
      _ => const NetworkError.unknown(),
    };
  }
}
