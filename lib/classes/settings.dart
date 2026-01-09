import "package:shared_preferences/shared_preferences.dart";

class Settings {
  static SharedPreferencesAsync? _asyncPrefs;

  // must be called once
  static void init() {
    _asyncPrefs = SharedPreferencesAsync();
  }

  static Future<void> setDarkMode(bool isDarkMode) async {
    await _asyncPrefs?.setBool("darkMode", isDarkMode);
  }

  static Future<bool> getDarkMode() async {
    // default to true (dark mode) for first time app is launched
    return await _asyncPrefs?.getBool("darkMode") ?? true;
  }
}




/*
// example for using SharedPreferencesAsync

final asyncPrefs = SharedPreferencesAsync();

await asyncPrefs.setBool('repeat', true);
await asyncPrefs.setString('action', 'Start');

final bool? repeat = await asyncPrefs.getBool('repeat');
final String? action = await asyncPrefs.getString('action');
*/