import "package:flutter/material.dart";
import "package:finger_training_app/timer_screen.dart";
import "package:finger_training_app/classes/exercise.dart";
import "package:finger_training_app/info_screen.dart";

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  /*
  // code for adding new routine, see new_routine.dart file
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final routine = defaultRoutine;
    // calculate routine length in seconds then convert to minutes
    int routineTotalSec = 0;
    int routineMin = 0;
    int routineSec = 0;
    for (int i = 0; i < routine.length; i++) {
      routineTotalSec += routine[i].duration;
    }
    routineTotalSec -= 3; // subtract 3 for the "get ready" phase
    routineMin = (routineTotalSec / 60).toInt();
    routineSec = (routineTotalSec % 60).toInt();

    // overlay that is opened to provide information
    void openInfoOverlay() {
      showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx) => InfoScreen(),
      );
    }

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
            Text(
              "First exercise:",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              routine[1].name, // index 1 so that it skips "get ready"
              style: TextStyle(fontSize: 25),
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Text(
              "Selected routine length:\n$routineMin minutes and $routineSec seconds.",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TimerScreen(routine),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Start session",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                IconButton(onPressed: openInfoOverlay, icon: Icon(Icons.info)),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
