import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

class FirebaseHomeService implements HomeService {
  final _usersCollectionId = 'Users';
  final _homesCollectionId = 'Homes';
  final _colorsCollectionId = 'Colors';

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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
}
