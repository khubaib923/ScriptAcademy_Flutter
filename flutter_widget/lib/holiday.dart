import 'package:flutter/material.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.holiday_village,
          size: 60,
          color: Colors.red.withOpacity(0.4),
        ),
      ),
    );
  }
}
