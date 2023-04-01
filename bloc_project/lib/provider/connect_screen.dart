import 'dart:developer';

import 'package:bloc_project/provider/connect_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}


class _ConnectScreenState extends State<ConnectScreen> {
  @override
  void initState() {
    super.initState();
    final provider=Provider.of<ConnectProvider>(context,listen: false);
    provider.check();

  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body: Center(
        child: Consumer<ConnectProvider>(
          builder: (context,value,child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                value.isCheck?const Text("Connected"):const Text("Disconnected"),


              ],
            );
          }
        ),
      ),
    );
  }
}
