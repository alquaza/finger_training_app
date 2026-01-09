import "package:flutter/material.dart";
import "package:finger_training_app/classes/settings.dart";

class SettingsScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  const SettingsScreen(this.onThemeChanged, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // this is not actually initializing dark mode, it will be immediately overwritten in initState
  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadDarkMode();
  }

  // called on initState, sets the isDarkMode boolean based on saved preference
  Future<void> _loadDarkMode() async {
    final darkMode = await Settings.getDarkMode();
    setState(() {
      isDarkMode = darkMode;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    await Settings.setDarkMode(value);
    setState(() {
      isDarkMode = value;
    });
    // notify the app to rebuild with new theme
    widget.onThemeChanged(value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
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
            title: const Text("Mute Sounds"),
            value: false,
            onChanged: (null),
          ),
        ],
      ),
    );
  }
}
