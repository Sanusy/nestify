import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nestify/service/dto/home_dto.dart';
import 'package:nestify/service/dto/user_profile_dto.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

class FirebaseHomeService implements HomeService {
  final _usersCollectionId = 'Users';
  final _homesCollectionId = 'Homes';

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createHomeDraft() async {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    try {
      final homeDraftDoc = _firestore.collection(_homesCollectionId).doc();
      final homeDraft = HomeDto(
        id: homeDraftDoc.id,
        adminId: userId,
        users: [userId],
        homeStatus: HomeStatus.draft,
      );

      final userDoc = _firestore.collection(_usersCollectionId).doc(userId);
      final userProfile = UserProfileDto(
        id: userId,
        homeId: homeDraftDoc.id,
        userProfileStatus: UserProfileStatus.draft,
      );

      final batch = _firestore.batch();

      batch.set(homeDraftDoc, homeDraft.toJson());
      batch.update(
        userDoc,
        {'userProfile': userProfile.toJson()},
      );

      await batch.commit();
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<HomeDto> userHome() async {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    try {
      final userDoc =
          await _firestore.collection(_usersCollectionId).doc(userId).get();
      final homeId = userDoc.data()!['userProfile']['homeId'];

      final homeDoc =
          await _firestore.collection(_homesCollectionId).doc(homeId).get();
      return HomeDto.fromJson(homeDoc.data()!);
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }
}
