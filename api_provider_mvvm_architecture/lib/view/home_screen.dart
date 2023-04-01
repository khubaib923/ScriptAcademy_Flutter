import 'package:api_provider_mvvm_architecture/utils/route/route_name.dart';
import 'package:api_provider_mvvm_architecture/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Utils.snackBarMessage("help me bro", context);
          },
          child: const Text("Clicked"),
        ),
      ),
    );
  }
}
