import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';

class FirebaseUserService implements UserService {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  String? currentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<String> logInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredentials =
        await _firebaseAuth.signInWithCredential(credential);

    return userCredentials.user?.uid ?? (throw const NetworkError.unknown());
  }
}
