import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: const Text("About Us", style: TextStyle(
            color: Colors.black,
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: heightVariable,
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Image(
                    width: 200,
                    height: 200,
                    image: AssetImage("images/bigcart_logo.png"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: const DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400
                    ),
                    child: Text("Big Cart is the Online shopping system where user can buy products digitally."
                        " We provides the variety of items on our store related to daily uses"
                        " Its mainly online where inventory manage by krachi wear houses"
                        " It is currently the largest online shopping network in karachi city,"
                        " outside of Karachi, operating in 12 markets across Asia.",)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
