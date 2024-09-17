import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/functions/network_info.dart';
import '../../../data/remote/profile_data.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class ProfileOperationsBloc extends Bloc<ProfileOperationsBlocEvent, ProfileOperationsBlocState> {
  final ProfileRepository profileRepository;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;
  ProfileOperationsBloc({
    required this.profileRepository,
    required this.networkInfo,
    required this.sharedPreferences,
  }) : super(EditInitial()) {
    on<ProfileOperationsBlocEvent>((event, emit) async {
      if (event is UpdateSingleFieldEvent) {
        try {
          emit(UpdateValueLoadingState());
          if (await networkInfo.isConnected) {
            await profileRepository.updateSingleField(event.newValue);
            emit(UpdateValueSuccessState(newValue: event.newValue));
          } else {
            emit(EditProfileBlocNoInternetConnectionState());
          }
        } catch (e) {
          emit(UpdateValueErrorState(errorMsg: e.toString()));
        }
      }
    });
  }
}
