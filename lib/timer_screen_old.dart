import "package:flutter/material.dart";
import "dart:async";
import "package:finger_training_app/classes/exercise.dart";
import "package:audioplayers/audioplayers.dart";
import "package:wakelock_plus/wakelock_plus.dart";
import "package:finger_training_app/classes/settings.dart";

class TimerScreen extends StatefulWidget {
  const TimerScreen(this.routine, {super.key});

  final List<Exercise> routine;

  @override
  State<TimerScreen> createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  Timer? timer;
  final player = AudioPlayer();

  int currentExerciseIndex = 0;
  int secondsRemaining = 0;

  bool isPaused = false;
  bool isFinished = false;

  bool soundEnabled = true;

  @override
  void initState() {
    super.initState();

    // initialize soundEnabled based on saved preference
    _loadSoundEnabled();

    // keeps the screen on while in active session (ie. prevents dimming or going to sleep)
    WakelockPlus.enable();

    // set options so it ignores silent mode (by being playback/media) but doesn't pause other sounds (like music)
    player.setAudioContext(
      AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: {
            AVAudioSessionOptions.mixWithOthers,
          },
        ),
        android: AudioContextAndroid(
          audioFocus: AndroidAudioFocus.none,
          usageType: AndroidUsageType.media,
          contentType: AndroidContentType.sonification,
        ),
      ),
    );

    startSession();
  }

  Future<void> _loadSoundEnabled() async {
    final soundEnabledPref = await Settings.getSoundEnabled();
    setState(() {
      soundEnabled = soundEnabledPref;
    });
  }

  void startSession() {
    secondsRemaining = widget.routine[currentExerciseIndex].duration;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // if startSession called while paused or finished, do nothing
      if (isPaused || isFinished) return;

      setState(() {
        if (secondsRemaining > 1) {
          secondsRemaining--;
        } else {
          playSound();
          moveToNextExercise();
        }
      });
    });
  }

  void moveToNextExercise() {
    currentExerciseIndex++;

    if (currentExerciseIndex >= widget.routine.length) {
      finishSession();
      return;
    }

    secondsRemaining = widget.routine[currentExerciseIndex].duration;
  }

  void playSound() {
    if (!soundEnabled) return;
    // will only play if sound is enabled
    unawaited(player.play(AssetSource('doot.mp3')));
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
    player.dispose();
    super.dispose();
  }

  // handles what happens if you try to leave (through "back" button or built-in phone mechanisms)
  Future<bool> showExitConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit session?"),
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
        : widget.routine[currentExerciseIndex].name;

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
          // allow screen to turn off again once not in active session
          WakelockPlus.disable();
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Training Session")),
        body: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(40, 0, 40, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70,
                  child: Text(
                    titleText,
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                // this text only appears during "Rest" exercise
                SizedBox(
                  height: 60,
                  child: titleText == "Rest"
                      ? Text(
                          "Work on your posture, stretch, drink some water, or lightly stretch your pinkies",
                          style: const TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        )
                      : null,
                ),
                const SizedBox(height: 10),
                if (!isFinished)
                  Text(
                    "$secondsRemaining",
                    style: const TextStyle(
                      fontSize: 150,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  child:
                      !isFinished &&
                          currentExerciseIndex + 1 < widget.routine.length
                      ? Text(
                          "Next exercise:\n${widget.routine[currentExerciseIndex + 1].name}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : null,
                ),
                const SizedBox(height: 30),
                if (!isFinished)
                  LinearProgressIndicator(
                    value: (currentExerciseIndex) / widget.routine.length,
                    minHeight: 20,
                  ),
                const SizedBox(height: 30),
                if (!isFinished)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 24,
                        icon: Icon(Icons.arrow_back),
                        onPressed: currentExerciseIndex > 0
                            ? () {
                                setState(() {
                                  currentExerciseIndex--;
                                  secondsRemaining = widget
                                      .routine[currentExerciseIndex]
                                      .duration;
                                });
                              }
                            // null if first exercise, which greys out the button
                            : null,
                      ),
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
                      IconButton(
                        iconSize: 24,
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {
                          setState(() {
                            moveToNextExercise();
                          });
                        },
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                if (!isFinished)
                  IconButton(
                    iconSize: 36,
                    icon: Icon(
                      soundEnabled ? Icons.volume_up : Icons.volume_off,
                    ),
                    onPressed: () {
                      setState(() {
                        soundEnabled = !soundEnabled;
                        unawaited(Settings.setSoundEnabled(soundEnabled));
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
