import 'package:flutter/material.dart';

import 'app_login.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToDashboard();
  }

  _navigateToDashboard()async{
    await Future.delayed(const Duration(milliseconds: 5000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: widthVariable,
            height: heightVariable,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/splash_pic.png"),
              ),
            ),
          ),
          Positioned(
            top: 70,
            child: Column(
              children: [
                const Text("Welcome to", style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700
                ),),
                Row(
                  children: const [
                    Text("BIG", style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF6CC51D),
                        fontWeight: FontWeight.w300
                    ),),
                    Text(" CART", style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF6CC51D),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                const SizedBox(height: 17,),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: const Text("Lorem ipsum dolor sit amet,"
                        " consetetur sadipscing elitr,"
                        " sed diam nonumy", style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                      color: Color(0xFF868889)
                    ),),
                  ),
                ),
                SizedBox(height: heightVariable/1.6,),
                const Text("POWERED BY", style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Poppins",
                  color: Color(0xFF868889)
                ),),
                const Text("T E C H  I D A R A", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF6CC51D)

                ),)
              ],
            ),
          ),
        ],
      )
    );
  }
}
