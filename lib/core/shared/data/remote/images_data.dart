import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../../../exceptions/firebase_exception.dart';
import '../../../exceptions/format_exception.dart';
import '../../../exceptions/platform_exception.dart';

class ImagesRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  ImagesRepository({
    required this.firestore,
    required this.storage,
  });
  Future<void> deleteSingleImage({
    required String collection,
    required String productId,
    required String imageUrl,
  }) async {
    try {
      await firestore.collection(collection).doc(productId).update({
        'images': FieldValue.arrayRemove([imageUrl])
      }).then((value) => storage.refFromURL(imageUrl).delete());
    } on FirebaseException catch (e) {
      throw TFirebaseException(code: e.code).message;
    } on FormatException catch (e) {
      throw TFormatException(code: e.toString());
    } on PlatformException catch (e) {
      throw TPlatformException(code: e.code).message;
    } catch (e) {
      throw 'NotKnownError';
    }
  }
}
