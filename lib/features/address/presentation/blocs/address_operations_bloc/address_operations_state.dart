part of 'address_operations_bloc.dart';

abstract class AddressOperationsBlocState {}

class AddressInitial extends AddressOperationsBlocState {}

class AddAddressLoadingState extends AddressOperationsBlocState {}

class AddAddressLoadedState extends AddressOperationsBlocState {}

class AddAddressErrorState extends AddressOperationsBlocState {
  final String errorMsg;
  AddAddressErrorState({required this.errorMsg});
}

class DeleteAddressStateSuccess extends AddressOperationsBlocState {}

class DeleteAddressStateError extends AddressOperationsBlocState {
  final String errorMsg;
  DeleteAddressStateError({required this.errorMsg});
}

class UpdateAddressStateSuccess extends AddressOperationsBlocState {}

class UpdateAddressStateError extends AddressOperationsBlocState {
  final String errorMsg;
  UpdateAddressStateError({required this.errorMsg});
}

class AddressOperationsNoInternetConnectionState extends AddressOperationsBlocState {}