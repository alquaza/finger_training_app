import "package:flutter/material.dart";
import "package:finger_training_app/classes/settings.dart";
import "dart:async";

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  const SettingsScreen(this.onThemeChanged, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // these are NOT setting defaults, they will be immediately overwritten in initState
  bool isDarkMode = true;
  bool isSoundEnabled = true;
  bool isVoiceEnabled = true;

  @override
  void initState() {
    super.initState();

    // these two just set the booleans based on saved preferences so that the
    // switches display correctly when the settings screen is opened
    _loadDarkMode();
    _loadSoundEnabled();
    _loadVoiceEnabled();
  }

  Future<void> _loadDarkMode() async {
    final darkMode = await Settings.getDarkMode();
    setState(() {
      isDarkMode = darkMode;
    });
  }

  void _toggleDarkMode(bool value) {
    unawaited(Settings.setDarkMode(value));
    setState(() {
      isDarkMode = value;
    });
    // notify the app to rebuild with new theme
    widget.onThemeChanged(value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _loadSoundEnabled() async {
    final soundEnabled = await Settings.getSoundEnabled();
    setState(() {
      isSoundEnabled = soundEnabled;
    });
  }

  void _toggleSoundEnabled(bool value) {
    unawaited(Settings.setSoundEnabled(value));
    setState(() {
      isSoundEnabled = value;
    });
  }

  Future<void> _loadVoiceEnabled() async {
    final voiceEnabled = await Settings.getVoiceEnabled();
    setState(() {
      isVoiceEnabled = voiceEnabled;
    });
  }

  void _toggleVoiceEnabled(bool value) {
    unawaited(Settings.setVoiceEnabled(value));
    setState(() {
      isVoiceEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ensure the switches are in sync with saved preferences
    // TODO not the best way to do this since it flickers the animation of the switch
    _loadDarkMode();
    _loadSoundEnabled();
    _loadVoiceEnabled();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: isDarkMode,
            onChanged: _toggleDarkMode,
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text("Sound Enabled"),
            subtitle: const Text("Sound effects during training"),
            value: isSoundEnabled,
            onChanged: _toggleSoundEnabled,
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text("Voice Countdown Enabled"),
            subtitle: const Text("Also requires sound to be enabled"),
            value: isVoiceEnabled,
            onChanged: isSoundEnabled ? _toggleVoiceEnabled : null,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
