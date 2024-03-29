import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/nestify_user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/firebase_file_mixin.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

class FirebaseHomeService  with FirebaseFileMixin implements HomeService {
  final _usersCollectionId = 'Users';
  final _homesCollectionId = 'Homes';
  final _colorsCollectionId = 'Colors';

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Future<List<UserColor>> availableColors() async {
    try {
      final colorsSnapshot =
          await _firestore.collection(_colorsCollectionId).get();

      return colorsSnapshot.docs.map((colorDoc) {
        return UserColor.fromJson(colorDoc.data());
      }).toList();
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<void> createHome({
    required HomeProfileDraftState homeDraft,
    required UserProfileDraftState userDraft,
  }) async {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    try {
      final userSnapshot =
          _firestore.collection(_usersCollectionId).doc(userId);
      final homeSnapshot = _firestore.collection(_homesCollectionId).doc();

      final userAvatarUrl = userDraft.userAvatar == null
          ? null
          : await uploadPicture(
              'Users/$userId/Avatar/Avatar_${DateTime.now().toString()}',
              userDraft.userAvatar!,
            );

      final homeAvatarUrl = homeDraft.homeAvatar == null
          ? null
          : await uploadPicture(
              'Homes/${homeSnapshot.id}/Avatar/Avatar_${DateTime.now().toString()}',
              userDraft.userAvatar!,
            );

      final homeModel = Home(
        id: homeSnapshot.id,
        homeName: homeDraft.homeName,
        adminId: userId,
        usersIds: [userId],
        address: homeDraft.homeAddress,
        about: homeDraft.homeAbout,
        avatarUrl: homeAvatarUrl,
      );

      final userModel = NestifyUser(
        id: userId,
        userName: userDraft.userName,
        homeId: homeModel.id,
        colorId: userDraft.selectedColor!.id,
        bio: userDraft.userBio,
        avatarUrl: userAvatarUrl,
      );

      final batch = _firestore.batch();

      batch.set(homeSnapshot, homeModel.toJson());
      batch.update(userSnapshot, userModel.toJson());

      return batch.commit();
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<void> deleteHome({required Home homeToDelete}) async {
    final batch = _firestore.batch();

    try {
      for (final user in homeToDelete.usersIds) {
        final userDoc = _firestore.collection(_usersCollectionId).doc(user);
        batch.update(userDoc, {'homeId': null});
      }

      final homeDoc =
          _firestore.collection(_homesCollectionId).doc(homeToDelete.id);
      batch.delete(homeDoc);

      await batch.commit();
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }

    // TODO: Consider removing it to Cloud Functions after they are available
    if (homeToDelete.avatarUrl != null) {
      try {
        _storage.refFromURL(homeToDelete.avatarUrl!).delete();
      } on FirebaseException {
        throw const FileError.failedToDelete();
      }
    }
  }

  @override
  Future<void> joinHome({
    required String homeId,
    required UserProfileDraftState userDraft,
  }) async {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    try {
      final userSnapshot =
          _firestore.collection(_usersCollectionId).doc(userId);
      final homeSnapshot =
          _firestore.collection(_homesCollectionId).doc(homeId);

      final userAvatarUrl = userDraft.userAvatar == null
          ? null
          : await uploadPicture(
              'Users/$userId/Avatar/Avatar_${DateTime.now().toString()}',
              userDraft.userAvatar!,
            );

      final userModel = NestifyUser(
        id: userId,
        userName: userDraft.userName,
        homeId: homeId,
        colorId: userDraft.selectedColor!.id,
        bio: userDraft.userBio,
        avatarUrl: userAvatarUrl,
      );

      final batch = _firestore.batch();

      batch.update(
        homeSnapshot,
        {
          'inviteUrl': null,
          'inviteId': null,
          'usersIds': FieldValue.arrayUnion([userId]),
        },
      );
      batch.update(userSnapshot, userModel.toJson());

      return batch.commit();
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<Home> home(String homeId) {
    try {
      return _firestore
          .collection(_homesCollectionId)
          .doc(homeId)
          .get()
          .then((homeSnapshot) => Home.fromJson(homeSnapshot.data()!));
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<Home?> homeByInviteUrl(String inviteUrl) {
    try {
      return _firestore
          .collection(_homesCollectionId)
          .where('inviteUrl', isEqualTo: inviteUrl)
          .get()
          .then((homesSnapshot) {
        final homeSnapshot = homesSnapshot.docs.firstOrNull;
        return homeSnapshot == null ? null : Home.fromJson(homeSnapshot.data());
      });
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<List<NestifyUser>> homeUsers(List<String> usersIds) {
    try {
      return _firestore
          .collection(_usersCollectionId)
          .where('id', whereIn: usersIds)
          .get()
          .then((usersSnapshot) {
        return usersSnapshot.docs
            .map((userSnapshot) => NestifyUser.fromJson(userSnapshot.data()))
            .toList();
      });
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<void> leaveHome({
    required String homeId,
    String? newAdminId,
  }) {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    try {
      final userSnapshot =
          _firestore.collection(_usersCollectionId).doc(userId);
      final homeSnapshot =
          _firestore.collection(_homesCollectionId).doc(homeId);

      final batch = _firestore.batch();

      batch.update(
        homeSnapshot,
        {
          'usersIds': FieldValue.arrayRemove([userId]),
          if (newAdminId != null) 'adminId': newAdminId,
        },
      );

      batch.update(userSnapshot, {
        'homeId': null,
      });

      return batch.commit();
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }

  @override
  Future<Home> editHome({
    required Home homeToEdit,
    File? newAvatar,
  }) async {
    final userId = _firebaseAuth.currentUser?.uid;

    if (userId == null) throw const NetworkError.notAuthenticated();

    try {
      final homeSnapshot =
          _firestore.collection(_homesCollectionId).doc(homeToEdit.id);

      final homeAvatarUrl = newAvatar == null
          ? homeToEdit.avatarUrl
          : await uploadPicture(
              'Homes/${homeSnapshot.id}/Avatar/Avatar_${DateTime.now().toString()}',
              newAvatar,
            );

      final homeModel = homeToEdit.copyWith(avatarUrl: homeAvatarUrl);

      final batch = _firestore.batch();

      batch.update(homeSnapshot, homeModel.toJson());

      await batch.commit();

      return homeModel;
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }
}
