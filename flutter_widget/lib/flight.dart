import 'package:flutter/material.dart';

class FlightScreen extends StatelessWidget {
  const FlightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.flight,
          size: 60,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }
}
