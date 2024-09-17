import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../data/lang_data.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  final LanguageCacheHelper languageCacheHelper;
  LocaleCubit({required this.languageCacheHelper}) : super(ChangeLocaleState(locale: const Locale('en')));

  Future<void> getSavedLanguage() async {
    final String cachedLanguageCode =
        await languageCacheHelper.getCachedLanguageCode();

    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    await languageCacheHelper.cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}
