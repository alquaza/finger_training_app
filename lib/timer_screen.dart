import "package:flutter/material.dart";
import "dart:async";

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? timer;
  int secondsRemaining = 5; // initial timer value
  bool timerActive = false;

  void startTimer() {
    if (timerActive) return;

    setState(() {
      timerActive = true;
      secondsRemaining = 10; // reset to 10 seconds
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          timer.cancel();
          timerActive = false;
          // timer completed - you can add actions here
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() {
      timerActive = false;
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      secondsRemaining = 10;
      timerActive = false;
    });
  }

  // this method is called when the widget is removed from the widget tree, ensures no memory leaks
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: make this dynamic based on selected exercise
            Text(
              "Front two fingers half-crimp",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "$secondsRemaining",
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              // TODO: implement start functionality
              onPressed: startTimer,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Start session", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
