// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:flutter/material.dart';

class DismissibleScreen extends StatefulWidget {
  const DismissibleScreen({Key? key}) : super(key: key);

  @override
  State<DismissibleScreen> createState() => _DismissibleScreenState();
}

class _DismissibleScreenState extends State<DismissibleScreen> {
  List<Trip>trip=[
    Trip(id: "0", location:"karachi", country:"Pakistan", fare: 100),
    Trip(id: "1", location:"Islamabad", country:"England", fare: 1020),
    Trip(id: "2", location:"Lahore", country:"America", fare: 1040),
    Trip(id: "3", location:"Sighapore", country:"India", fare: 1050),
    Trip(id: "4", location:"Multan", country:"Bangladesh", fare: 1600),
    Trip(id: "5", location:"Peshawar", country:"Srilanka", fare: 1600),
    Trip(id: "6", location:"Sultan", country:"Austrilia", fare: 1007),
    Trip(id: "7", location:"Quetta", country:"Russia", fare: 1006),
    Trip(id: "8", location:"Nazimabad", country:"Afghanistan", fare: 1600),
  ];
  @override
  void initState(){
    super.initState();
    trip;
  }

  void completeTheTrip(){
    log("Complete the trip");
  }
  void cancelledTheTrip(){
    log("Cancelled the trip");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dismissible"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: trip.length,
          itemBuilder:(context,index){
          return Dismissible(
              key: Key(trip[index].id),
              child:  ListTile(
                title: Text(trip[index].location,style: const TextStyle(fontSize: 24),),
                subtitle: Text(trip[index].country,style: const TextStyle(fontSize: 16),),
                leading: const Icon(Icons.flight),
                trailing: Text(trip[index].fare.toString(),style:const  TextStyle(fontSize: 16,color: Colors.red),),
              ),
            background: Container(
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.done,color: Colors.white,size: 50,),
                  SizedBox(width: 30,),
                  Text("Completed",style: TextStyle(color: Colors.white,fontSize: 20),)
                ],
              ),
            ),
           secondaryBackground:Container(
             color: Colors.red,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: const [


                 Text("Cancelled",style: TextStyle(color: Colors.white,fontSize: 20),),
                 SizedBox(width: 30,),
                 Icon(Icons.delete,color: Colors.white,size: 50,),
               ],
             ),
           ),
            onDismissed: (DismissDirection direction){
                direction==DismissDirection.startToEnd?completeTheTrip():cancelledTheTrip();
                setState((){
                  trip.removeAt(index);
                });
            },
          );
          }
      ),
    );
  }
}

class Trip{


  Trip({required this.id, required this.location,required this.country,required this.fare});
  String id;
  String location;
  String country;
  int fare;

}
