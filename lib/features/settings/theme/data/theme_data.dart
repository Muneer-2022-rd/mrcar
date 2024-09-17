import 'package:shared_preferences/shared_preferences.dart';

class ThemeCacheHelper {
  final SharedPreferences sharedPreferences;
  ThemeCacheHelper({
    required this.sharedPreferences,
  });
  Future<void> cacheThemeIndex(int themeIndex) async {
    sharedPreferences.setInt("THEME_INDEX", themeIndex);
  }

  Future<int> getCachedThemeIndex() async {
    final cachedThemeIndex = sharedPreferences.getInt("THEME_INDEX");
    if (cachedThemeIndex != null) {
      return cachedThemeIndex;
    } else {
      return 0;
    }
  }
}
