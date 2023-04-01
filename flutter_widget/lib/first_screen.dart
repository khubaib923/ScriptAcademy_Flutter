import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget/show_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController textEditingController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  GlobalKey<FormState> globalKey=GlobalKey();
  String? response;


  String _selectedItem = "Banana";
  List<String>item = ["Apple", "Banana", "Grapes", "Orange"];
  DateTime dateTime=DateTime.now();
  TimeOfDay time = TimeOfDay.now();

Future<void>selectedTimes(BuildContext context)async{
  TimeOfDay? timeOfDay=await showTimePicker(
      context: context,
      initialTime: time
  );
  if(timeOfDay!=null && timeOfDay!=time){
    setState((){
      time=timeOfDay;
    });
  }
}


  Future<void> selectedDate(BuildContext context) async{
      DateTime? pickDate= await showDatePicker(
           context: context,
           initialDate:dateTime,
           firstDate: DateTime(2001),
           lastDate: DateTime(2030),
       );
      if(pickDate!=null && pickDate!=dateTime){
        setState((){
          dateTime=pickDate;
        });
      }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Bar"),
      ),
      body: SingleChildScrollView(
        child:Column(
              children: [
                DropdownButton(
                    value: _selectedItem,
                    items: item.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child:  Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedItem = value.toString();
                      });
                    }
                ),
                const Text("Selected Date",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ElevatedButton(onPressed: (){
                  //selectedDate(context);
                  selectedTimes(context);
                }, child:const Text("Pick Date")),
                Text("Selected date is $dateTime ",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                Container(
                  height: 150,
                  width: 150,
                  decoration:     const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    gradient: LinearGradient(
                  begin:Alignment.bottomCenter,
                  end: Alignment.centerLeft,
                        colors: [
                          Colors.green,
                          Colors.yellow,
                        ]
                    ),
                    boxShadow: [
                       BoxShadow(
                        color: Colors.pink,
                        blurRadius:10,
                        offset: Offset(0,0),
                      )
                    ]
                  ),
                  child: const Center(child: Text("Container",style: TextStyle(fontSize: 20),)),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.logout)),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.logout)),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.logout)),


                  ],
                ),
                  Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SizedBox(
                     height: 100,
                     width: 200,

                     child:  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 10,
                      color: Colors.green,
                      shadowColor: Colors.yellow,
                      margin: const EdgeInsets.all(10),
                      child:  Center(child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Hello World",style: TextStyle(fontSize: 30),),
                          Text("Hello World",style: TextStyle(fontSize: 30),),
                        ],
                      )
                      ),
                ),
                   ),
                 ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:  [
                      Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        labelStyle: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                          label: const Text("Movies",style: TextStyle(fontSize: 20),),
                        avatar: const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.play_circle),
                        ),
                        deleteIcon: const Icon(Icons.delete),
                        deleteIconColor: Colors.red,
                        onDeleted: (){},
                      ),
                      Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        labelStyle: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                        label: const Text("Cartoon",style: TextStyle(fontSize: 20),),
                        avatar: const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.play_circle),
                        ),
                        deleteIcon: const Icon(Icons.delete),
                        deleteIconColor: Colors.red,
                        onDeleted: (){},
                      ),
                      Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        labelStyle: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                        label: const Text("Drama",style: TextStyle(fontSize: 20),),
                        avatar: const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.play_circle),
                        ),
                        deleteIcon: const Icon(Icons.delete),
                        deleteIconColor: Colors.red,
                        onDeleted: (){},
                      ),
                      Chip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        labelStyle: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                        label: const Text("Match",style: TextStyle(fontSize: 20),),
                        avatar: const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.play_circle),
                        ),
                        deleteIcon: const Icon(Icons.delete),
                        deleteIconColor: Colors.red,
                        onDeleted: (){},
                      )
                    ],
                  ),
                ),
                Form(
                  key: globalKey,
                  child:Builder(
                    builder: (context) {
                      return Column(
                            children: [
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "input is empty";
                                  }
                                  return null;
                                },
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                  hintText: "username",
                                ),
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "password is empty";

                                  }
                                  return null;
                                },
                                controller: passwordController,
                                decoration: const InputDecoration(
                                  hintText: "password",
                                ),
                              ),
                              ElevatedButton(onPressed: ()async{
                                // globalKey.currentState!.validate();
                                Form.of(context)!.validate();
                                 response=await Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen(name: textEditingController.text.trim(),)));
                                 log(response.toString());
                                setState(() {

                                });

                              },

                                  child: response==null?const Text("Check"): Text(response.toString()),



                              ),
                            ],
                          );
                    }
                  )


                ),



              ],
            )

      ),
    );
  }
}

