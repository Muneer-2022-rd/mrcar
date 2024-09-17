part of 'add_edit_delete_shop_bloc.dart';

abstract class AddEditDeleteShopEvent {}

class AddShopEvent extends AddEditDeleteShopEvent {
  final String? name;
  File? image;
  final List<String>? services;
  final AddressModel address;
  List<File>? images;
  List<OpenDay> opens;
  AddShopEvent({
    required this.name,
    required this.image,
    required this.services,
    required this.images,
    required this.opens,
    required this.address,
  });
}

class GetMyAddressesInShopEvent extends AddEditDeleteShopEvent {}

class EditExistShopEvent extends AddEditDeleteShopEvent {
  final String? name;
  File? image;
  final List<String>? services;
  final AddressModel address;
  List<File>? images;
  List<OpenDay> opens;
  final String? productId;
  EditExistShopEvent({
    this.productId,
    required this.name,
    required this.image,
    required this.services,
    required this.images,
    required this.opens,
    required this.address,
  });
}

class DeleteExistShopEvent extends AddEditDeleteShopEvent {
  final String productId;
  DeleteExistShopEvent({required this.productId});
}