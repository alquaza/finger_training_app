# finger_training_app

Built by Alex Chen.

An app to help you train your finger strength (for rock climbing). It uses the methodology
discussed by Emil Abrahamsson in his Youtube videos.

The app's planned features:

- Ability to modify the routine and add new ones
- Habit tracking calendar (colours in the days you do it)
- Monthly check-ins where you can write down where you are currently at (to see gains)
- Allow changing settings:
  - Optional voice/beeping/other sound between phases so you don't have to look at phone
  - Optional notifications to remind you to train (choose how many times and how often)
  - Switch to/from dark mode

Not features but other things:

- Handle case where someone closes the app (minimize and/or close) while exercising
  - Seems like default behaviour when someone minimizes or turns off screen is to just keep counting, verify that this behaviour is also consistent with the rest of the functionality later on
- Add small banner ads while you do your session (no audio)

Next to-do:

- Option for voice (with countdown) vs beep
- Remember whether mute was set/unset
- Track workouts
- Add skip button for each exercise
- Show how long and how many exercises are left in routine while doing it
- Allow editing of default routine

Notes to self:

- To debug on physical iOS: developer mode -> run -> trust device (in general -> vpn) -> set xcode scheme to release
