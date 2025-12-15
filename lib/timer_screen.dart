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

  // handles what happens if you try to leave (through "back" button or built-in phone mechanisms)
  Future<bool> showExitConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit routine?"),
            content: const Text(
              "Are you sure you would like to exit your routine? Your progress will not be saved.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final String titleText = isFinished
        ? "Good job! Session completed."
        : defaultRoutine[currentExerciseIndex].name;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        bool shouldExit;
        if (isFinished) {
          shouldExit = true;
        } else {
          togglePause();
          shouldExit = await showExitConfirmation(context);
        }

        if (shouldExit && context.mounted) {
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
