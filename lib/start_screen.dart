import "package:flutter/material.dart";
import "package:finger_training_app/timer_screen.dart";
import "package:finger_training_app/models/exercise.dart";

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
            /*
            // TODO: add dropdown menu to allow user to select routine
            Text(
              "Placeholder for dropdown menu to select routine",
            ),
            */
            Spacer(),
            // TODO: make this dynamic based on selected exercise
            Text(
              "First exercise:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              defaultRoutine[1].name,
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
