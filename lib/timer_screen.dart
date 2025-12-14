import "package:flutter/material.dart";
import "dart:async";
import "package:finger_training_app/models/exercise.dart";

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  Timer? timer;

  int currentExerciseIndex = 0;
  int secondsRemaining = 0;

  bool isPaused = false;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    startSession();
  }

  void startSession() {
    secondsRemaining = defaultRoutine[currentExerciseIndex].duration;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // if startSession called while paused or finished, do nothing
      if (isPaused || isFinished) return;

      setState(() {
        if (secondsRemaining > 1) {
          secondsRemaining--;
        } else {
          playBeep();
          moveToNextExercise();
        }
      });
    });
  }

  void moveToNextExercise() {
    currentExerciseIndex++;

    if (currentExerciseIndex >= defaultRoutine.length) {
      finishSession();
      return;
    }

    secondsRemaining = defaultRoutine[currentExerciseIndex].duration;
  }

  void playBeep() {
    // TODO: add functionality to play a beep sound
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void finishSession() {
    timer?.cancel();
    isFinished = true;
  }

  // this method is called when the widget is removed from the widget tree, ensures no memory leaks
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String titleText = isFinished
        ? "Good job! Session completed."
        : defaultRoutine[currentExerciseIndex].name;

    // TODO: ask them to confirm before allowing user to go back
    return Scaffold(
      appBar: AppBar(title: const Text("Training Session")),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                titleText,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              if (!isFinished)
                Text(
                  "$secondsRemaining",
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 30),
              if (!isFinished &&
                  currentExerciseIndex + 1 < defaultRoutine.length)
                Text(
                  "Next exercise: ${defaultRoutine[currentExerciseIndex + 1].name}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              const SizedBox(height: 30),
              if (!isFinished)
                ElevatedButton(
                  onPressed: togglePause,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      isPaused ? "Resume" : "Pause",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
