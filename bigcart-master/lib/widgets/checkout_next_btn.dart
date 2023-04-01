import 'package:bigcart/screens/app_checkout.dart';
import 'package:bigcart/screens/order_successfull.dart';
import 'package:flutter/material.dart';
class NextButton extends StatelessWidget {

  BuildContext? childContext;
  NextButton({this.childContext});

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
          height: 50,
          width: widthVariable,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF6CC51D)),
              shadowColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: (){
              if (Form.of(childContext!)?.validate() ?? false) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> OrderSuccess()));
              }
            },
            child: const Text(
              "Next",style: TextStyle(
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
