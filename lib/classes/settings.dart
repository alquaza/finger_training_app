import "package:shared_preferences/shared_preferences.dart";
import "dart:async";

class Settings {
  static SharedPreferencesAsync? _asyncPrefs;

  // must be called once
  static void init() {
    _asyncPrefs = SharedPreferencesAsync();
  }

  static Future<void> setDarkMode(bool isDarkMode) async {
    unawaited(_asyncPrefs?.setBool("darkMode", isDarkMode));
  }

  static Future<bool> getDarkMode() async {
    // default to true (dark mode) for first time app is launched
    return await _asyncPrefs?.getBool("darkMode") ?? true;
  }

  static Future<void> setSoundEnabled(bool isSoundEnabled) async {
    unawaited(_asyncPrefs?.setBool("soundEnabled", isSoundEnabled));
  }

  static Future<bool> getSoundEnabled() async {
    // default to true (sound enabled) for first time app is launched
    return await _asyncPrefs?.getBool("soundEnabled") ?? true;
  }

  static Future<void> setVoiceEnabled(bool isVoiceEnabled) async {
    unawaited(_asyncPrefs?.setBool("voiceEnabled", isVoiceEnabled));
  }

  static Future<bool> getVoiceEnabled() async {
    // default to true (voice enabled) for first time app is launched
    return await _asyncPrefs?.getBool("voiceEnabled") ?? true;
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