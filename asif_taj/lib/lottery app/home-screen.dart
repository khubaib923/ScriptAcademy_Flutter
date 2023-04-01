import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random=Random();



  int x=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lottery App"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text("Lottery winning number is 4",style: GoogleFonts.arsenal()),
            const SizedBox(height: 10,),
            AnimatedContainer(
              duration:x==4? const Duration(seconds:2):const Duration(seconds: 0),
              curve: Curves.fastOutSlowIn,

              height: x==4?500:250,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: x==4?Colors.orange:Colors.grey[200],
                borderRadius: BorderRadius.circular(10),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(x==4?Icons.done_all:Icons.dangerous,color: x==4?Colors.green:Colors.red,size: 30,),
                  const SizedBox(height: 10,),
                  Text("Better luck next time your number is $x\ntry again",style: TextStyle(fontFamily:"Edu VIC WA NT Beginner" ),)
                ],
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState((){
            x=random.nextInt(5);
          });
        },
        child: const Icon(Icons.restart_alt),
      ),

    );
  }
}
