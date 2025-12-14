import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? timer;

  int secondsRemaining = 3;
  bool isPaused = false;
  bool isFinished = false;

  String statusText = "Get ready";

  /// Sequence: 10, 5 repeated 3 times
  final List<int> _intervals = [10, 5, 10, 5, 10, 5];
  int currentIntervalIndex = -1; // starts before the first work interval

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPaused || isFinished) return;

      setState(() {
        if (secondsRemaining > 0) {
          secondsRemaining--;
        } else {
          moveToNextPhase();
        }
      });
    });
  }

  void moveToNextPhase() {
    // Finished "Get ready"
    if (currentIntervalIndex == -1) {
      currentIntervalIndex = 0;
      secondsRemaining = _intervals[currentIntervalIndex];
      statusText = "Work";
      return;
    }

    currentIntervalIndex++;

    // All intervals completed
    if (currentIntervalIndex >= _intervals.length) {
      finishSession();
      return;
    }

    secondsRemaining = _intervals[currentIntervalIndex];
    statusText = _intervals[currentIntervalIndex] == 10 ? "Work" : "Rest";
  }

  void finishSession() {
    timer?.cancel();
    isFinished = true;
    statusText = "Good job!";
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
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
    return Scaffold(
      appBar: AppBar(title: const Text('Training Session')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                statusText,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                isFinished ? "" : "$secondsRemaining",
                style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              if (!isFinished)
                ElevatedButton(
                  onPressed: togglePause,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
