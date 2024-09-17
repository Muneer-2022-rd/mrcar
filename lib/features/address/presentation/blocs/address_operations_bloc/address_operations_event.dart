part of 'address_operations_bloc.dart';

abstract class AddressOperationsBlocEvent {}

class AddNewAddressEvent extends AddressOperationsBlocEvent {
  final String lat;
  final String long;
  final String country;
  final String city;
  final String state;
  final String name;
  final String phone;
  bool? available;
  AddNewAddressEvent({
    required this.lat,
    required this.long,
    required this.country,
    required this.city,
    required this.state,
    required this.name,
    required this.phone,
    this.available,
  });
}

class DeleteExistAddressEvent extends AddressOperationsBlocEvent {
  final String addressId;
  DeleteExistAddressEvent({required this.addressId});
}

class UpdateExistAddressEvent extends AddressOperationsBlocEvent {
  final String addressId;
  final bool available;
  UpdateExistAddressEvent({required this.addressId, required this.available});
}