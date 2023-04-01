import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';

class FirebaseUserService implements UserService {
  final _usersCollectionId = 'Users';

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  bool isLoggedIn() {
    return _firebaseAuth.currentUser?.uid != null;
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

    final userSnapshot = await _firestore
        .collection(_usersCollectionId)
        .doc(userCredentials.user?.uid)
        .get();
    if (!userSnapshot.exists) {
      userSnapshot.reference.set({'name': userCredentials.user?.displayName});
    }

    return userCredentials.user?.uid ?? (throw const NetworkError.unknown());
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<String?> homeId() async {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    try {
      final userSnapshot =
          await _firestore.collection(_usersCollectionId).doc(userId).get();

      return userSnapshot.data()?['homeId'];
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }
}
