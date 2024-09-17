import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/network_info.dart';
import '../../../data/model/address_model.dart';
import '../../../data/remote/address_data.dart';

part 'my_addresses_event.dart';
part 'my_addresses_state.dart';

class MyAddressesBloc extends Bloc<MyAddressesEvent, MyAddressesState> {
  final AddressRepository addressRepository;
  final NetworkInfo networkInfo;
  final FirebaseAuth auth;
  MyAddressesBloc({
    required this.addressRepository,
    required this.auth,
    required this.networkInfo,
  }) : super(MyAddressesInitial()) {
    on<MyAddressesEvent>((event, emit) async {
      if (event is GetMyAddressesEvent) {
        try {
          if (await networkInfo.isConnected) {
            emit(MyAddressesLoadingState());
            final userId = auth.currentUser!.uid;
            final List<AddressModel> addresses =
                await addressRepository.getMyAddresses(userId: userId);
            emit(MyAddressesLoadedState(addresses: addresses));
          } else {
            emit(MyAddressesNoInternetConnectionState());
          }
        } catch (e) {
          emit(MyAddressesErrorState(errorMsg: e.toString()));
        }
      }
    });
  }
}
