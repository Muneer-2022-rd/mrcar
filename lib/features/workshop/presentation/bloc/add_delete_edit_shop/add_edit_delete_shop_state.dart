part of 'add_edit_delete_shop_bloc.dart';

abstract class AddEditDeleteShopState {}

class AddEditDeleteShopInitial extends AddEditDeleteShopState {}

class AddShopLoadingState extends AddEditDeleteShopState {}

class AddShopLoadedState extends AddEditDeleteShopState {}

class AddShopErrorState extends AddEditDeleteShopState {
  final String errorMsg;
  AddShopErrorState({required this.errorMsg});
}

class MyAddressesInShopLoadingState extends AddEditDeleteShopState {}

class MyAddressesInShopLoadedState extends AddEditDeleteShopState {
  final List<AddressModel> addresses;
  MyAddressesInShopLoadedState({required this.addresses});
}

class MyAddressesInShopErrorState extends AddEditDeleteShopState {
  final String errorMsg;
  MyAddressesInShopErrorState({required this.errorMsg});
}

class EditShopLoadingState extends AddEditDeleteShopState {}

class EditShopLoadedState extends AddEditDeleteShopState {}

class EditShopErrorState extends AddEditDeleteShopState {
  final String errorMsg;
  EditShopErrorState({required this.errorMsg});
}

class DeleteShopLoadedState extends AddEditDeleteShopState {
  final String productId;
  DeleteShopLoadedState({required this.productId});
}

class DeleteShopErrorState extends AddEditDeleteShopState {
  final String errorMsg;
  DeleteShopErrorState({required this.errorMsg});
}