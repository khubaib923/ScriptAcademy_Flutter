import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static void showToastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      // fontSize: 18,
      // toastLength: Toast.LENGTH_SHORT,
    );
  }
  static void flushBarErrorMessage(String message,BuildContext context){
    Flushbar(
      message: message,
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      icon: const Icon(Icons.error,size: 20,color: Colors.white,),
      borderRadius: BorderRadius.circular(8),
      forwardAnimationCurve: Curves.decelerate,
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.easeInOut,
      duration: const Duration(seconds: 3),
      positionOffset: 20,
    ).show(context);
  }

  static void snackBarMessage(String message,BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,duration: const Duration(seconds: 2)));
  }
}