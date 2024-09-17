part of 'my_addresses_bloc.dart';

abstract class MyAddressesState {}

class MyAddressesInitial extends MyAddressesState {}

class MyAddressesLoadingState extends MyAddressesState {}

class MyAddressesLoadedState extends MyAddressesState {
  final List<AddressModel> addresses;
  MyAddressesLoadedState({required this.addresses});
}

class MyAddressesErrorState extends MyAddressesState {
  final String errorMsg;
  MyAddressesErrorState({required this.errorMsg});
}

class MyAddressesNoInternetConnectionState extends MyAddressesState {}