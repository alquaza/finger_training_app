import "package:flutter/material.dart";

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Text("Front two fingers half-crimp"),
        SizedBox(height: 100),
        Text("5"),
        SizedBox(height: 50),
      ],
    );
  }
}
