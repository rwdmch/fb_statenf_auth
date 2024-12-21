import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_statenf_auth/models/custom_error.dart';
import 'package:fb_statenf_auth/models/user_model.dart';

import '../constants/db_constants.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;

  ProfileRepository({required this.firebaseFirestore});

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();

      if (userDoc.exists) {
        final User currentUser = User.fromDoc(userDoc);
        return currentUser;
      }
      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
