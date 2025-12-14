import "package:flutter/material.dart";
import "package:finger_training_app/timer_screen.dart";
import "package:finger_training_app/tracking_screen.dart";
import "package:finger_training_app/settings_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> screens = const [
    TimerScreen(),
    TrackingScreen(),
    SettingsScreen(),
  ];

  int selectedIndex = 0;

  // the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
