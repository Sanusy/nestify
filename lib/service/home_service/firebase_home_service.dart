import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nestify/service/home_service/home_service.dart';

class FirebaseHomeService implements HomeService {
  final _usersCollectionId = 'Users';
  final _homesCollectionId = 'Homes';

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
}
