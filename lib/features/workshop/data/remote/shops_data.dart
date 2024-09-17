import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../../core/exceptions/firebase_exception.dart';
import '../../../../core/exceptions/format_exception.dart';
import '../../../../core/exceptions/platform_exception.dart';
import '../models/shop_model.dart';

class ShopsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ShopsRepository({required this.firestore, required this.auth});
  Future<List<ShopModel>> getAllShops() async {
    try {
      final documentSnapshot = await firestore.collection('shops').get();
      final List<ShopModel> list =
          documentSnapshot.docs.map((e) => ShopModel.fromSnapshot(e)).toList();
      return list;
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
  Future<List<ShopModel>> getMyShops() async {
    final userId = auth.currentUser!.uid;
    try {
      final documentSnapshot = await firestore.collection('shops').where('userId',isEqualTo: userId).get();
      final List<ShopModel> list =
          documentSnapshot.docs.map((e) => ShopModel.fromSnapshot(e)).toList();
      return list;
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
