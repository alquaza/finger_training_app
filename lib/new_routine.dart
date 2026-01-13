/*
      CURRENTLY UNUSED FILE
      implement in the future to allowed creating of new routines
      attach to startscreen (some commented out code)
*/

import "package:flutter/material.dart";

class NewRoutine extends StatefulWidget {
  const NewRoutine({super.key});

  @override
  State<NewRoutine> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewRoutine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 30,
            decoration: InputDecoration(label: Text("Exercise name")),
          ),
        ],
      ),
    );
  }
}
