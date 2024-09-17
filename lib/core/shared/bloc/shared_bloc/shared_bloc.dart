import 'dart:io';

import 'package:cars_equipments_shop/core/functions/network_info.dart';
import 'package:cars_equipments_shop/core/shared/data/remote/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final SharedRepository sharedRepository;
  final FirebaseAuth auth;
  final NetworkInfo networkInfo;
  SharedBloc(
      {required this.sharedRepository,
      required this.auth,
      required this.networkInfo})
      : super(SharedInitial()) {
    on<SharedEvent>((event, emit) async {
      if (event is UploadImageEvent) {
        emit(UploadImageLoadingState());
        if (await networkInfo.isConnected) {
          String? thmbnailURL;
          if (event.image != null) {
            thmbnailURL = await sharedRepository.uploadImageFileData(
              event.collection!,
              event.image!,
              event.image!.path.split('/').last,
            );
          }
          await sharedRepository.updateSingleField(
            collection: event.collection!,
            id: auth.currentUser!.uid,
            json: {event.fieldChanged!: thmbnailURL},
          );
          emit(UploadImageSuccessState(image: event.image!));
        } else {
          emit(NoInternetConnectionState());
        }
      }
    });
  }
}
