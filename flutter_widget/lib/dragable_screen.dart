import 'package:flutter/material.dart';

class DraggableScreen extends StatefulWidget {
  const DraggableScreen({Key? key}) : super(key: key);

  @override
  State<DraggableScreen> createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {
int number=5;
int sum=0;
  Draggable<int> buildDraggable(){
    return Draggable(

        feedback: Text(number.toString(),style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),),
        childWhenDragging:Text(number.toString(),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),),
      data: number,
      child:  Text(number.toString(),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),

    );
  }

  DragTarget<int> buildDragTarget(){
    return DragTarget(
        builder: (context,acceptedData,rejectedData){
         if(acceptedData.isEmpty){
           return Text(sum.toString(),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),);
         }
         else{
           sum+=acceptedData[0]!.toInt();
           return Text(sum.toString(),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),);
         }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Interactivity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:  [
            const Text("Drag the number",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          buildDraggable(),
          const SizedBox(height: 100,),
          Container(
            height: 150,
            color: Colors.black,
            child: Center(
              child: buildDragTarget(),
            ),
          )
          ],
        ),
      ),
    );
  }
}
