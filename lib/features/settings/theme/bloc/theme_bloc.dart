import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../data/theme_data.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeCacheHelper themeCacheHelper;
  ThemeBloc({required this.themeCacheHelper}) : super(ThemeInitial()) {
    on<ThemeEvent>((event, emit) async {
      if (event is GetCurrentThemeEvent) {
        final themeIndex = await themeCacheHelper.getCachedThemeIndex();
        final theme = AppTheme.values
            .firstWhere((appTheme) => appTheme.index == themeIndex);
        emit(LoadedThemeState(themeData: appTheme[theme]!));
      } else if (event is ThemeChangedEvent) {
        final themeIndex = event.theme.index;
        await themeCacheHelper.cacheThemeIndex(themeIndex);
        emit(LoadedThemeState(themeData: appTheme[event.theme]!));
      }
    });
  }
}
