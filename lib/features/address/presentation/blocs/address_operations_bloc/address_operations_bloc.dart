import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/functions/network_info.dart';
import '../../../data/model/address_model.dart';
import '../../../data/remote/address_data.dart';
part 'address_operations_event.dart';
part 'address_operations_state.dart';

class AddressOperationsBloc
    extends Bloc<AddressOperationsBlocEvent, AddressOperationsBlocState> {
  final AddressRepository addressRepository;
  final FirebaseAuth auth;
  final NetworkInfo networkInfo;
  AddressOperationsBloc({
    required this.addressRepository,
    required this.auth,
    required this.networkInfo,
  }) : super(AddressInitial()) {
    on<AddressOperationsBlocEvent>((event, emit) async {
      if(await networkInfo.isConnected) {
        if (event is AddNewAddressEvent) {
        try {
          emit(AddAddressLoadingState());
          String? userId = auth.currentUser!.uid;
          int? currentTime = DateTime.now().millisecondsSinceEpoch;
          DateTime now = DateTime.now();
            String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
          final AddressModel addressModel = AddressModel(
            lat: event.lat.trim(),
            long: event.long.trim(),
            country: event.country.trim(),
            city: event.city.trim(),
            state: event.state.trim(),
            name: event.name.trim(),
            phone: event.phone.trim(),
            id: currentTime.toString().trim(),
            userId: userId.trim(),
            dateCreated: formattedDate
          );
          await addressRepository.addNewAddress(addressModel: addressModel);
          emit(AddAddressLoadedState());
        } catch (e) {
          emit(AddAddressErrorState(errorMsg: e.toString()));
        }
      } else if (event is DeleteExistAddressEvent) {
        try {
          await addressRepository.deleteAddressRecord(event.addressId);
          emit(DeleteAddressStateSuccess());
        } catch (error) {
          emit(DeleteAddressStateError(errorMsg: error.toString()));
        }
      } else if (event is UpdateExistAddressEvent) {
        try {
          await addressRepository.updateAddressRecord(
            event.addressId,
            {'available': event.available},
          );
          emit(UpdateAddressStateSuccess());
        } catch (error) {
          emit(UpdateAddressStateError(errorMsg: error.toString()));
        }
      }
      } else {
        emit(AddressOperationsNoInternetConnectionState());
      }
    });
  }
}
