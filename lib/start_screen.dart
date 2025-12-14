import "package:flutter/material.dart";
import "package:finger_training_app/timer_screen.dart";

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Dropdown menu to select routine",
            ),
            Spacer(),
            // TODO: make this dynamic based on selected exercise
            Text(
              "First exercise:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              "Front two fingers half-crimp",
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TimerScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Start session", style: TextStyle(fontSize: 20)),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
