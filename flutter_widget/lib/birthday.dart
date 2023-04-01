import 'package:flutter/material.dart';

class BirthDayScreen extends StatelessWidget {
  const BirthDayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.cake,
          size: 60,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }
}
