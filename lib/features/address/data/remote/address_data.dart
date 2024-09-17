import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../../../core/exceptions/firebase_exception.dart';
import '../../../../core/exceptions/format_exception.dart';
import '../../../../core/exceptions/platform_exception.dart';
import '../model/address_model.dart';

class AddressRepository {
  final FirebaseFirestore firestore;
  AddressRepository({required this.firestore});
  Future<void> addNewAddress({
    required AddressModel addressModel,
  }) async {
    try {
      await firestore
          .collection('addresses')
          .doc(addressModel.id)
          .set(addressModel.toJson());
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

  Future<List<AddressModel>> getMyAddresses({required String userId}) async {
    try {
      final documentSnapshot = await firestore
          .collection('addresses')
          .where('userId', isEqualTo: userId)
          .get();
      final List<AddressModel> list = documentSnapshot.docs
          .map((e) => AddressModel.fromSnapshot(e))
          .toList();
      return list;
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

  Future<void> updateAddressRecord(
    String addressId,
    Map<String, dynamic> data,
  ) async {
    try {
      await firestore.collection('addresses').doc(addressId).update(data);
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

  Future<void> deleteAddressRecord(
    String addressId,
  ) async {
    try {
      await firestore.collection('addresses').doc(addressId).delete();
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
