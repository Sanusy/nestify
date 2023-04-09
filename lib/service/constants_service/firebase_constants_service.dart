import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nestify/service/constants_service/constants_service.dart';
import 'package:nestify/service/network_error.dart';

class FirebaseConstantsService implements ConstantsService {
  final _constantsDocPath = 'Constants/Constants';

  final _firestore = FirebaseFirestore.instance;

  @override
  Future<String> supportEmail() async {
    try {
      final constantsDoc = await _firestore.doc(_constantsDocPath).get();
      return constantsDoc.data()!['supportEmail'];
    } on FirebaseException catch (error) {
      throw error.toNetworkError();
    }
  }
}
