import "package:flutter/material.dart";
import "package:finger_training_app/timer_screen.dart";
import "package:finger_training_app/navigation.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // this title is not displayed inside the app
      title: "Finger Strength Training",
      home: Scaffold(
        // bar at the top
        appBar: AppBar(title: const Text("Finger Training")),
        // main content of the app screen
        body: TimerScreen(),
        // navigation bar at the bottom
        bottomNavigationBar: Navigation(),
      ),
    );
  }
}
