import 'package:asif_taj/drawer_screen.dart';
import 'package:asif_taj/lottery%20app/home-screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
     debugShowCheckedModeBanner: false,
      home: DrawerScreen()
    );
  }
}


