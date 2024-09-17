import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../../../../../core/exceptions/firebase_exception.dart';
import '../../../../../core/exceptions/format_exception.dart';
import '../../../../../core/exceptions/platform_exception.dart';
import '../models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirebaseAuth auth;
  ProfileRepository({
    required this.firestore,
    required this.auth,
    required this.storage,
  });

  Future<UserModel> fetchUserRecord() async {
    try {
      final documentSnapshot =
          await firestore.collection('users').doc(auth.currentUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(code: e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserRecord(UserModel updateModel) async {
    try {
      await firestore
          .collection('users')
          .doc(updateModel.userId)
          .update(updateModel.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(code: e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(code: e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(code: e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      rethrow;
    }
  }
}
