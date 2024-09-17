import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/data/remote/shared_data.dart';
import '../../../../address/data/model/address_model.dart';
import '../../../../address/data/remote/address_data.dart';
import '../../../data/models/shop_model.dart';
import '../../../data/remote/add_edit_delete_shop_data.dart';

part 'add_edit_delete_shop_event.dart';
part 'add_edit_delete_shop_state.dart';

class AddEditDeleteShopBloc
    extends Bloc<AddEditDeleteShopEvent, AddEditDeleteShopState> {
  final AddEditDeleteShopsRepository addEditDeleteShopsRepository;
  final FirebaseAuth auth;
  final AddressRepository addressRepository;
  final SharedRepository sharedRepository;
  AddEditDeleteShopBloc({
    required this.addEditDeleteShopsRepository,
    required this.auth,
    required this.addressRepository,
    required this.sharedRepository,
  }) : super(AddEditDeleteShopInitial()) {
    on<AddEditDeleteShopEvent>((event, emit) {});

    on<AddShopEvent>((event, emit) async {
      final userId = auth.currentUser!.uid;
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      try {
        emit(AddShopLoadingState());
        String? thmbnailURL;
        if (event.image != null) {
          thmbnailURL = await sharedRepository.uploadImageFileData(
            'shops',
            event.image!,
            event.image!.path.split('/').last,
          );
        }
        List<String>? imagesURL = [];
        if (event.images != []) {
          for (var image in event.images!) {
            final imageURL =
                await sharedRepository.uploadImageFileData(
              'shops',
              image,
              image.path.split('/').last,
            );
            imagesURL.add(imageURL);
          }
        }
        final ShopModel shopModel = ShopModel(
          name: event.name ?? '',
          address: event.address,
          image: thmbnailURL ?? '',
          dateAdded: currentTime.toString(),
          services: event.services ?? [],
          images: imagesURL,
          opens: event.opens,
          userId: userId,
        );
        await addEditDeleteShopsRepository.addNewShop(shop: shopModel);
        emit(AddShopLoadedState());
      } catch (e) {
        emit(AddShopErrorState(errorMsg: e.toString()));
      }
    });

    on<GetMyAddressesInShopEvent>((event, emit) async {
      final userId = auth.currentUser!.uid;
      try {
        emit(MyAddressesInShopLoadingState());
        final List<AddressModel> addresses =
            await addressRepository.getMyAddresses(userId: userId);
        emit(MyAddressesInShopLoadedState(addresses: addresses));
      } catch (e) {
        emit(MyAddressesInShopErrorState(errorMsg: e.toString()));
      }
    });

    on<EditExistShopEvent>((event, emit) async {
      final userId = auth.currentUser!.uid;
      try {
        emit(EditShopLoadingState());
        String? thmbnailURL;
        if (event.image != null) {
          thmbnailURL = await sharedRepository.uploadImageFileData(
            'shops',
            event.image!,
            event.image!.path.split('/').last,
          );
        }
        List<String>? imagesURL = [];
        if (event.images != []) {
          for (var image in event.images!) {
            final imageURL =
                await sharedRepository.uploadImageFileData(
              'shops',
              image,
              image.path.split('/').last,
            );
            imagesURL.add(imageURL);
          }
        }
        final ShopModel shopModel = ShopModel(
          name: event.name ?? '',
          address: event.address,
          image: thmbnailURL ?? '',
          dateAdded: event.productId,
          services: event.services ?? [],
          images: imagesURL,
          opens: event.opens,
          userId: userId,
        );
        await addEditDeleteShopsRepository.editExistShop(shop: shopModel);
        emit(EditShopLoadedState());
      } catch (e) {
        emit(EditShopErrorState(errorMsg: e.toString()));
      }
    });

    on<DeleteExistShopEvent>((event, emit) async {
      try {
        await addEditDeleteShopsRepository.deleteExistShop(productId: event.productId);
        emit(DeleteShopLoadedState(productId: event.productId));
      } catch (e) {
        emit(DeleteShopErrorState(errorMsg: e.toString()));
      }
    });
  }
}
