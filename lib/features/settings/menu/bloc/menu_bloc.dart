import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/functions/network_info.dart';
import '../data/remote/menu_data.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository menuRepository;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  MenuBloc({
    required this.menuRepository,
    required this.networkInfo,
    required this.sharedPreferences,
  }) : super(MenuInitial()) {
    
    on<MenuEvent>((event, emit) async {
      if (event is FetchUserSettingsDataEvent) {
        try {
          emit(FetchUserSettingsDataLoadingState());
          if (await networkInfo.isConnected) {
            final user = await menuRepository.fetchUserRecord();
            emit(FetchUserSettingsDataSuccessState(userData: user));
            sharedPreferences.setString('userSettings', jsonEncode(user));
          } else {
            final cachedUser = sharedPreferences.getString('userSettings');
            emit(FetchUserSettingsDataNoInternetConnection(
                userData: jsonDecode(cachedUser!)));
          }
        } catch (e) {
          emit(FetchUserSettingsDataErrorState(errorMsg: e.toString()));
        }
      }
    });
  }
}
