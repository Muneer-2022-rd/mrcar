import 'dart:io';

import 'package:cars_equipments_shop/core/functions/helper_functions.dart';
import 'package:cars_equipments_shop/features/auth/profile/data/models/user_model.dart';
import 'package:cars_equipments_shop/features/auth/register/data/remote/register_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/functions/network_info.dart';
import '../../../../../core/shared/data/remote/shared_data.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository _registerRepository;
  final SharedRepository _sharedRepository;
  final NetworkInfo _networkInfo;
  final FirebaseAuth _auth;

  RegisterBloc({
    required RegisterRepository registerRepository,
    required SharedRepository sharedRepository,
    required NetworkInfo networkInfo,
    required FirebaseAuth auth,
  })  : _registerRepository = registerRepository,
        _sharedRepository = sharedRepository,
        _networkInfo = networkInfo,
        _auth = auth,
        super(RegisterInitial()) {
    on<RegisterEvent>(_onEvent);
  }

  Future<void> _onEvent(
    RegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    if (event is SignUpEvent) {
      await _handleSignUpEvent(event, emit);
    } else if (event is CheckEmailValidationEvent) {
      await _handleCheckEmailValidationEvent(emit);
    } else if (event is ResendEmailValidationEvent) {
      await _handleResendEmailValidationEvent(emit);
    }
  }

  Future<void> _handleSignUpEvent(
    SignUpEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoadingState());

    if (!await _networkInfo.isConnected) {
      emit(NoInternetConnectionState());
      return;
    }

    try {
      final userCredential =
          await _registerRepository.registerWithEmailAndPassword(
        email: event.userEmail,
        password: event.password,
      );

      final String formattedDate = THelperFunctions.getCurrentDate();
      final String? thumbnailURL = event.userImageProfile != null
          ? await _sharedRepository.uploadImageFileData(
              'users',
              event.userImageProfile!,
              event.userImageProfile!.path.split('/').last,
            )
          : null;

      final String? pushToken = await FirebaseMessaging.instance.getToken();
      final user = UserModel(
        userId: userCredential.user!.uid.trim(),
        userEmail: event.userEmail.trim(),
        userName: event.userName.trim(),
        userFirst: event.userFirst.trim(),
        userLast: event.userLast.trim(),
        userPhone: event.userPhone,
        userImage: thumbnailURL,
        userGender: event.userGender.trim(),
        userDateBirth: event.userDateBirth.trim(),
        lastActive: '',
        about: '',
        isOnline: false,
        pushToken: pushToken,
        accountDateCreation: formattedDate,
        providerType: userCredential.credential!.signInMethod,
      );

      await _registerRepository.saveUserRecord(userModel: user);
      await _registerRepository.sendEmailVerification();
      emit(RegisterSuccessState(email: event.userEmail));
    } catch (e) {
      emit(RegisterErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _handleCheckEmailValidationEvent(
    Emitter<RegisterState> emit,
  ) async {
    emit(CheckValidationLoadingState());

    if (!await _networkInfo.isConnected) {
      emit(NoInternetConnectionState());
      return;
    }

    try {
      final user = _auth.currentUser;
      await user!.reload();

      if (user.emailVerified) {
        emit(CheckValidationSuccessState());
      } else {
        emit(const CheckValidationErrorState(
            errorMsg: 'messages_email_not_verified'));
      }
    } catch (e) {
      emit(CheckValidationErrorState(errorMsg: e.toString()));
    }
  }

  Future<void> _handleResendEmailValidationEvent(
    Emitter<RegisterState> emit,
  ) async {
    if (!await _networkInfo.isConnected) {
      emit(NoInternetConnectionState());
      return;
    }

    try {
      await _registerRepository.sendEmailVerification();
    } catch (e) {
      emit(CheckValidationErrorState(errorMsg: e.toString()));
    }
  }
}