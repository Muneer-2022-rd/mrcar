import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../../../exceptions/firebase_exception.dart';
import '../../../exceptions/format_exception.dart';
import '../../../exceptions/platform_exception.dart';

class SharedRepository {
  final FirebaseStorage storage;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  SharedRepository({
    required this.firestore,
    required this.auth,
    required this.storage,
  });
  Future<String> uploadImageFileData(
    String path,
    File image,
    String name,
  ) async {
    try {
      final ref = storage.ref(path).child(name);
      await ref.putFile(image);
      final url = ref.getDownloadURL();
      return url;
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

  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );
      return imageData;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImageUint8ListData(
    String path,
    Uint8List image,
    String name,
  ) async {
    try {
      final ref = storage.ref(path).child(name);
      await ref.putData(image);
      final url = ref.getDownloadURL();
      return url;
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

  Future<void> updateSingleField({
    required String collection,
    required String id,
    required Map<String, dynamic> json,
  }) async {
    try {
      await firestore
          .collection(collection)
          .doc(id)
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
}
