import 'dart:convert';

import 'package:cars_equipments_shop/core/functions/network_info.dart';
import 'package:cars_equipments_shop/features/auth/profile/data/models/user_model.dart';
import 'package:cars_equipments_shop/features/auth/profile/data/remote/profile_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;
  final FirebaseAuth auth;
  ProfileBloc({
    required this.profileRepository,
    required this.networkInfo,
    required this.sharedPreferences,
    required this.auth,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is FetchUserDataEvent) {
        try {
          emit(FetchUserDataLoadingState());
          if (await networkInfo.isConnected) {
            final user = await profileRepository.fetchUserRecord();
            emit(FetchUserDataSuccessState(userModel: user));
            sharedPreferences.setString('user', jsonEncode(user.toJson()));
          } else {
            final cachedUser = sharedPreferences.getString('user');
            emit(FetchUserDataNoInternetConnection(
                userModel: UserModel.fromJson(jsonDecode(cachedUser!))));
          }
        } catch (e) {
          emit(FetchUserDataErrorState(errorMsg: e.toString()));
        }
      } else if (event is LogoutEvent) {
        await auth.signOut();
        await GoogleSignIn().signOut();
        sharedPreferences.clear();
        emit(LogoutState());
      }
    });
  }
}
