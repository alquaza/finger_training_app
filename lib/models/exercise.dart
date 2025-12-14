class Exercise {
  const Exercise(this.name, this.duration);

  final String name;
  final int duration; // duration is in seconds
}

// remember to start with "get ready" and end with a position not a rest

/*
// for testing, comment out other routine
List<Exercise> defaultRoutine = [
  Exercise("Get ready", 3),
  Exercise("Position 1", 2),
  Exercise("Rest 1", 2),
  Exercise("Position 2", 2),
];
*/

List<Exercise> defaultRoutine = [
  Exercise("Get ready", 3),

  // 6 sets of four finger half-crimp
  Exercise("Four finger half-crimp", 10),
  Exercise("Rest", 20),
  Exercise("Four finger half-crimp", 10),
  Exercise("Rest", 20),
  Exercise("Four finger half-crimp", 10),
  Exercise("Rest", 20),
  Exercise("Four finger half-crimp", 10),
  Exercise("Rest", 20),
  Exercise("Four finger half-crimp", 10),
  Exercise("Rest", 20),
  Exercise("Four finger half-crimp", 10),
  Exercise("Rest", 20),

  // 6 sets of 3 finger drag (no pinkie)
  Exercise("Three finger drag (no pinkie)", 10),
  Exercise("Rest", 20),
  Exercise("Three finger drag (no pinkie)", 10),
  Exercise("Rest", 20),
  Exercise("Three finger drag (no pinkie)", 10),
  Exercise("Rest", 20),
  Exercise("Three finger drag (no pinkie)", 10),
  Exercise("Rest", 20),
  Exercise("Three finger drag (no pinkie)", 10),
  Exercise("Rest", 20),
  Exercise("Three finger drag (no pinkie)", 10),
  Exercise("Rest", 20),

  // 2 sets of two finger drag (index and middle)
  Exercise("Two finger drag (index/middle)", 10),
  Exercise("Rest", 20),
  Exercise("Two finger drag (index/middle)", 10),
  Exercise("Rest", 20),

  // 2 sets of two finger drag (middle and ring)
  Exercise("Two finger drag (middle/ring)", 10),
  Exercise("Rest", 20),
  Exercise("Two finger drag (middle/ring)", 10),
  Exercise("Rest", 20),

  // 2 sets of two finger half crimp (index and middle)
  Exercise("Two finger half-crimp (index/middle)", 10),
  Exercise("Rest", 20),
  Exercise("Two finger half-crimp (index/middle)", 10),
  Exercise("Rest", 20),

  // 2 sets of two finger half crimp (middle and ring)
  Exercise("Two finger half-crimp (middle/ring)", 10),
  Exercise("Rest", 20),
  Exercise("Two finger half-crimp (middle/ring)", 10),
];
