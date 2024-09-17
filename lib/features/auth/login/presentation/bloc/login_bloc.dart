import 'package:cars_equipments_shop/features/auth/login/data/remote/login_data.dart';
import 'package:cars_equipments_shop/features/auth/register/data/remote/register_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/functions/helper_functions.dart';
import '../../../../../core/functions/network_info.dart';
import '../../../profile/data/models/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final NetworkInfo networkInfo;
  final LoginRepository loginRepository;
  final RegisterRepository registerRepository;
  final SharedPreferences sharedPreferences;
  final FirebaseAuth auth;
  LoginBloc({
    required this.networkInfo,
    required this.loginRepository,
    required this.registerRepository,
    required this.sharedPreferences,
    required this.auth,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is SignInEvent) {
        try {
          emit(LoginLoadingState());
          if (await networkInfo.isConnected) {
            await loginRepository.loginWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );
            emit(LoginSuccessState());
          } else {
            emit(NoInternetConnectionState());
          }
        } catch (e) {
          emit(LoginErrorState(errorMsg: e.toString()));
        }
      } else if (event is GoogleSignInEvent) {
        try {
          emit(GoogleLoginLoadingState());
          if (await networkInfo.isConnected) {
            final userCredential = await loginRepository.loginViaGoogle();
            final userExist =
                await loginRepository.checkUserExists(userCredential.user!.uid);
            if (!userExist) {
              final userAuth = userCredential.user;
              final fullName = UserModel.nameParts(userAuth?.displayName);
              final username = UserModel.generateUserName(fullName);
              String formattedDate = THelperFunctions.getCurrentDate();
              String? pushToken = await FirebaseMessaging.instance.getToken();
              final user = UserModel(
                userId: userAuth!.uid.trim(),
                userEmail: userAuth.email?.trim() ?? "",
                userName: username.trim(),
                userFirst: fullName[0],
                userLast: fullName[1],
                userPhone: PhoneNumberModel(
                  phoneNumber: '',
                  countryCode: '',
                ),
                userImage: userAuth.photoURL?.trim() ?? "",
                userGender: "",
                userDateBirth: "",
                lastActive: '',
                about: '',
                isOnline: false,
                pushToken: pushToken,
                accountDateCreation: formattedDate, 
                providerType: userCredential.credential!.signInMethod,
              );
              await registerRepository.saveUserRecord(userModel: user);
            }
            sharedPreferences.setString("step", "2");
            emit(GoogleLoginSuccessState());
          } else {
            emit(NoInternetConnectionState());
          }
        } catch (e) {
          emit(GoogleLoginErrorState(errorMsg: e.toString()));
        }
      } else if (event is PhoneSignInEvent) {
        try {
          emit(PhoneLoginLoadingState());
          if (await networkInfo.isConnected) {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: event.id,
              smsCode: event.otp,
            );
            final userCredential = await auth.signInWithCredential(credential);
            final userExist =
                await loginRepository.checkUserExists(userCredential.user!.uid);
            if (!userExist) {
              final userAuth = userCredential.user;
              String formattedDate = THelperFunctions.getCurrentDate();
              String? pushToken = await FirebaseMessaging.instance.getToken();
              final user = UserModel(
                userId: userAuth!.uid.trim(),
                userEmail: "",
                userName: "mr_${event.phoneNmuber}",
                userFirst: '',
                userLast: '',
                userPhone: PhoneNumberModel(
                  phoneNumber: event.phoneNmuber,
                  countryCode: event.dialCode,
                ),
                userImage: '',
                userGender: "",
                userDateBirth: "",
                lastActive: '',
                about: '',
                isOnline: false,
                pushToken: pushToken,
                accountDateCreation: formattedDate, 
                providerType: userCredential.user!.providerData[0].providerId,
                
              );
              await registerRepository.saveUserRecord(userModel: user);
            }
            sharedPreferences.setString("step", "2");
            emit(PhoneLoginSuccessState());
          } else {
            emit(NoInternetConnectionState());
          }
        } catch (e) {
          emit(PhoneLoginErrorState(errorMsg: e.toString()));
        }
      }
    });
  }
}
