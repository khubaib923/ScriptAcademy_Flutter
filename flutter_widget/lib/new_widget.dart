import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:like_button/like_button.dart';


class NewWidgetScreen extends StatefulWidget {
  const NewWidgetScreen({Key? key}) : super(key: key);

  @override
  State<NewWidgetScreen> createState() => _NewWidgetScreenState();
}

class _NewWidgetScreenState extends State<NewWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return const  AboutDialog(
                          applicationIcon: FlutterLogo(),
                          applicationLegalese: "Legalese",
                          applicationVersion: "version 1.0.0",
                          applicationName: "Flutter App",
                          children: [
                            Text("This is a text created by flutter"),

                          ],
                        );
                      }
                  );
                },
                child:const  Text("Show About Dialog"),
              ),
              const SizedBox(height: 20,),
              const AboutListTile(
                icon: Icon(Icons.info),
                applicationName: "Flutter App",
                applicationVersion: "version 1.0.0",
                applicationLegalese: "Legalese",
                applicationIcon: FlutterLogo(),
                aboutBoxChildren: [
                  Text("This is a text created by flutter")
                ],
              ),
              const SizedBox(height: 20,),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: null,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 100,
                    child: AbsorbPointer(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade200
                        ),
                        onPressed: (){},
                        child: null,
                      ),
                    ),
                  )
                ],
              ),
            // const SizedBox(height: 30,),
            //   Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: SlideAction(
            //     borderRadius: 12,
            //     elevation: 0,
            //     innerColor: Colors.deepPurple,
            //     outerColor: Colors.deepPurple[200],
            //     sliderButtonIcon: const Icon(Icons.lock_open,color: Colors.white,),
            //     text: "Slide to unlock",
            //     textStyle:const TextStyle(color: Colors.white,fontSize: 20),
            //     //animationDuration: const Duration(seconds: 1),
            //     submittedIcon:const  Icon(Icons.done_all,color: Colors.white,),
            //     sliderRotate: false,
            //     //reversed: true,
            //
            //     onSubmit: (){
            //       log("Work Completed");
            //     },
            //   ),
            // ),
              const SizedBox(height: 20,),
              Slidable(
                startActionPane: ActionPane(
                  motion:const StretchMotion() ,
                  children: [
                    SlidableAction(
                        onPressed: (context){},
                      icon: Icons.phone,
                      backgroundColor: Colors.green,
                    ),
                    SlidableAction(
                      onPressed: (context){},
                      icon: Icons.settings,
                      flex: 2,
                      backgroundColor: Colors.pink,
                    )
                  ],
                ),
                endActionPane: ActionPane(
                  motion:const StretchMotion() ,
                  children: [
                    SlidableAction(
                      onPressed: (context){},
                      icon: Icons.logout,
                      backgroundColor: Colors.red,
                    ),
                    SlidableAction(
                      onPressed: (context){},
                      icon: Icons.message,
                      flex: 2,
                      backgroundColor: Colors.pink,
                    )
                  ],
                ),

                child: Container(
                  color: Colors.grey[300],

                  child: const ListTile(
                    title: Text("Khubaib Irfan"),
                    subtitle: Text("0313-2330609"),
                    leading: Icon(Icons.person),

                  ),
                ),
              ),
              const SizedBox(height: 20,),
                LikeButton(
                size: 80,
                animationDuration: const Duration(seconds: 2),
                likeCount: 20,
                countPostion: CountPostion.bottom,
                 likeBuilder: (isTapped){
                  return  Icon(
                    Icons.bookmark,
                    color: isTapped ? Colors.deepPurple:Colors.grey,
                    size: 80,

                  );
                 },

              ),



            ],
          ),
        ),
      ),
    );
  }
}
