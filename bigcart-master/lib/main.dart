import 'package:bigcart/screens/app_dashboard.dart';
import 'package:bigcart/screens/app_login.dart';
import 'package:bigcart/screens/app_signup.dart';
import 'package:bigcart/screens/app_splashscreen.dart';
import 'package:bigcart/state/state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppStateWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}



