import 'package:bigcart/widgets/order_successfull_btn.dart';
import 'package:flutter/material.dart';

class OrderSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GoToHomeButton(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
           SizedBox(
             height: 200,
             width: 200,
             child: Image(
               image: AssetImage("images/congrats_icon.png"),
             ),
           ),
            SizedBox(height: 45,),
            Text("Congrats!", style: TextStyle(
                fontSize: 24,
                fontFamily: "Poppins",
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 16,),
            Text("Your order #12345 is\nSuccessfully Received", style: TextStyle(
              color: Color(0xFFB1B1B1),
              fontFamily: "Poppins",
              fontSize: 16
            ),)
          ],
        ),
      ),
    );
  }
}
