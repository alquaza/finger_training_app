class Exercise {
  const Exercise(this.name, this.duration);

  final String name;
  final int duration; // duration is in seconds
}

// remember to start with "get ready" and end with a position not a rest

List<Exercise> testRoutine = [
  Exercise("Get ready", 2),
  Exercise("Position 1", 2),
  Exercise("Rest 1", 2),
];

List<Exercise> defaultRoutine = [
  Exercise("Get ready", 3),

  Exercise("Position 1", 10),
  Exercise("Break 1", 20),

  Exercise("Position 2", 10),
  Exercise("Break 2", 20),

  Exercise("Position 3", 10),
  Exercise("Break 3", 20),

  Exercise("Position 4", 10),
  Exercise("Break 4", 20),

  Exercise("Position 5", 10),
  Exercise("Break 5", 20),

  Exercise("Position 6", 10),
  Exercise("Break 6", 20),

  Exercise("Position 7", 10),
];
