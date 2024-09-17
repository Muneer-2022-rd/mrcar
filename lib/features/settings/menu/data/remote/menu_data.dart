import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../../../core/exceptions/firebase_exception.dart';
import '../../../../../core/exceptions/format_exception.dart';
import '../../../../../core/exceptions/platform_exception.dart';

class MenuRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  MenuRepository({
    required this.firestore,
    required this.auth,
  });

  Future<Map<String, dynamic>> fetchUserRecord() async {
    try {
      final documentSnapshot =
          await firestore.collection('users').doc(auth.currentUser?.uid).get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        if (data != null) {
          final email = data['user_email'] as String?;
          final username = data['user_name'] as String?;
          final imgaeProfile = data['user_image'] as String?;
          final provider = data['provider_type'] as String?;
          final phone = data['user_phone'] as Map<String, dynamic>?;
          return {
            'user_email': email,
            'user_name': username,
            'user_image': imgaeProfile,
            'provider_type': provider,
            'user_phone': phone,
          };
        }
      }

      return {};
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
