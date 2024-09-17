import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/auth/login/presentation/pages/login_page.dart';
import '../../../../features/navigation_bar/presentation/pages/navigation_menu.dart';

part 'select_home_event.dart';
part 'select_home_state.dart';

class SelectHomeBloc extends Bloc<SelectHomeEvent, SelectHomeState> {
  final SharedPreferences sharedPreferences;
  SelectHomeBloc({required this.sharedPreferences})
      : super(SelectHomeInitial()) {
    on<SelectHomeEvent>((event, emit) async {
      if (event is UpdateSelectedHomeEvent) {
        Widget selectpage = event.selectPage;
        String? step = sharedPreferences.getString("step");
        await Future.delayed(const Duration(seconds: 1));
        if (step == "1") {
          selectpage = const LoginPage();
        } else if (step == "2") {
          selectpage = const NavigationMenu();
        }
        emit(UpdateSelectedHomeState(selectPage: selectpage));
      }
    });
  }
}