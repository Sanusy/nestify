import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nestify/service/dto/home_dto.dart';
import 'package:nestify/service/dto/update_home_dto.dart';
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
    final userId = _userId;

    try {
      final homeDraftDoc = _firestore.collection(_homesCollectionId).doc();
      final homeDraft = HomeDto(
        id: homeDraftDoc.id,
        adminId: userId,
        users: [userId],
        name: '',
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
    try {
      final homeDoc = await _firestore
          .collection(_homesCollectionId)
          .doc(await _homeId)
          .get();
      return HomeDto.fromJson(homeDoc.data()!);
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<void> discardCreateHome() async {
    try {
      final userSnapshot =
          await _firestore.collection(_usersCollectionId).doc(_userId).get();

      final homeDoc =
          _firestore.collection(_homesCollectionId).doc(await _homeId);

      final batch = _firestore.batch();

      batch.delete(homeDoc);
      batch.update(userSnapshot.reference, {
        'userProfile': null,
      });

      batch.commit();
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<void> createHome(UpdateHomeDto homeInfo) async {
    try {
      final homeDoc =
          _firestore.collection(_homesCollectionId).doc(await _homeId);

      final json = homeInfo.toJson();

      await homeDoc.update(json);
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  String get _userId {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    return userId;
  }

  Future<String> get _homeId async {
    try {
      final userSnapshot =
          await _firestore.collection(_usersCollectionId).doc(_userId).get();
      return userSnapshot.data()!['userProfile']['homeId'];
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }
}
