import 'package:bigcart/screens/app_checkout.dart';
import 'package:bigcart/screens/app_dashboard.dart';
import 'package:flutter/material.dart';
class GoToHomeButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 17, right: 17),
      child: Container(
          height: 50,
          width: widthVariable,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF6CC51D)),
              shadowColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> Dashboard()));
            },
            child: const Text(
              "Go To Home",style: TextStyle(
                fontSize: 22,
                fontFamily: "Poppins",
                color: Colors.white
            ),
            ),
          )
      ),
    );
  }
}
