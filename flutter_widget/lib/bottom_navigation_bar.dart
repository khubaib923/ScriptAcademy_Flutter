import 'package:flutter/material.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final list=[
    const Center(child: Text("kkk",style: TextStyle(fontSize: 30),),),
    const Center(child: Text("kkkkkk",style: TextStyle(fontSize: 30),),),
    const Center(child: Text("k",style: TextStyle(fontSize: 30),),),
    const Center(child: Text("kk",style: TextStyle(fontSize: 30),),),
  ];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
       bottomNavigationBar: BottomNavigationBar(

         currentIndex: index,
         onTap: (indexes){
           setState((){
             index=indexes;
           });
         },
         type: BottomNavigationBarType.shifting,
         items: const [
           BottomNavigationBarItem(
               backgroundColor: Colors.blue,
               label: "kk",
               icon: Icon(Icons.add)),
           BottomNavigationBarItem(
             backgroundColor: Colors.orange,
               icon: Icon(Icons.add),
             label: "add",
           ),

           BottomNavigationBarItem(
               label: "ff",
               icon: Icon(Icons.add)),
           BottomNavigationBarItem(
               label: "ll",
               icon: Icon(Icons.add)),
         ],
       ),
    );
  }
}
