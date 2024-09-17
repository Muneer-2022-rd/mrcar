import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/exceptions/firebase_auth_exception.dart';
import '../../../../../core/exceptions/firebase_exception.dart';
import '../../../../../core/exceptions/format_exception.dart';
import '../../../../../core/exceptions/platform_exception.dart';

class LoginRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  LoginRepository({required this.auth, required this.firestore});
  Future<bool> checkUserExists(String userId) async {
    try {
      final userDoc = firestore.collection('users').doc(userId);
      final docSnapshot = await userDoc.get();
      return docSnapshot.exists;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
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

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
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

  Future<UserCredential> loginViaGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(code: e.code).message;
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
