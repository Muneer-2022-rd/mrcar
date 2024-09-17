import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/shop_model.dart';

class AddEditDeleteShopsRepository {
  final FirebaseFirestore firestore;
  AddEditDeleteShopsRepository({required this.firestore});
  Future<void> addNewShop({
    required ShopModel shop,
  }) async {
    try {
      await firestore
          .collection("shops")
          .doc(shop.dateAdded.toString())
          .set(shop.toJson());
    } catch (e) {
      rethrow;
    }
  }
  Future<void> editExistShop({
    required ShopModel shop,
  }) async {
    try {
      await firestore
          .collection("shops")
          .doc(shop.dateAdded.toString())
          .set(shop.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteExistShop({
    required String productId,
  }) async {
    try {
      await firestore
          .collection("shops")
          .doc(productId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
