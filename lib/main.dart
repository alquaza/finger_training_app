import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:finger_training_app/start_screen.dart";
import "package:finger_training_app/tracking_screen.dart";
import "package:finger_training_app/settings_screen.dart";
import "package:finger_training_app/classes/settings.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Settings.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  // this is NOT the line that sets the default theme, the variable just has to be initialized
  // even though it will be immediately overwritten in initState
  ThemeMode themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDarkMode = await Settings.getDarkMode();
    setState(() {
      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // keeps track of which screen is currently selected
    final List<Widget> screens = [
      const StartScreen(),
      const TrackingScreen(),
      SettingsScreen(setThemeMode),
    ];

    return MaterialApp(
      // theming
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,

      // this title is not displayed inside the app
      title: "Finger Strength Training",
      home: Scaffold(
        // bar at the top, nothing in it yet so just for spacing
        appBar: AppBar(), //title: const Text("Finger Training")
        // main content of the app screen
        body: screens[selectedIndex],
        // navigation bar at the bottom
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.play_arrow),
              label: "Start",
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: "Tracking",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
