

// ignore_for_file: override_on_non_overriding_member

import 'dart:developer';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SecondScreen extends StatefulWidget {
  String name;
   SecondScreen({Key? key,required this.name}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with SingleTickerProviderStateMixin{
  //TabController? tabController;
  List<String>title=["Home","Setting","Email","Phone","Logout"];
  List<IconData>icon=[Icons.home,Icons.settings,Icons.email,Icons.phone,Icons.logout];

  bool isAlert=false;

@override
void initState(){
  super.initState();
  // tabController=TabController(length: 3, vsync:this);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),

        actions: [
          IconButton(onPressed: ()async{
            await showDialog(context: context,
                builder: (context){
                return  AlertDialog(
                  title: const Text("Sign out"),
                  content: const Text("Are you sure you want to sign out?"),
                  actions: [
                    TextButton(onPressed: (){
                     setState((){
                       isAlert=true;
                       Navigator.pop(context);
                     });
                    }, child: const Text("Yes")),
                    TextButton(onPressed: (){
                     setState((){
                       isAlert=false;
                       Navigator.pop(context);
                     });
                    }, child: const Text("No")),

                  ],
                );
                }
            );
            log(isAlert.toString());
            if(isAlert)
           {

             // ignore: use_build_context_synchronously
             Navigator.pop(context,"don");
           }
          },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Stack(
            //alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 300,
                width: 300,
                color: Colors.red,
              ),
              Container(
                height: 250,
                width: 250,
                color: Colors.green,
              ),
              Container(
                height: 200,
                width: 200,
                color: Colors.yellow,
              ),
              Container(
                height: 190,
                width: 190,
                color: Colors.pink,
              ),


            ],
          ),
          const SizedBox(height: 20,),
          Stack(
            //alignment: AlignmentDirectional.topStart,
            children: const [
              CircleAvatar(
                radius: 60,
                child: Icon(Icons.shopping_cart,size: 50,),
              ),
              Positioned(
                right: 20,
                bottom: 70,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: Text("10",style: TextStyle(fontSize: 20),),
                ),
              ),


            ],
          ),
          // Card(
          //   child: ListView(
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     children: const [
          //       ListTile(
          //         title: Text("khubaib"),
          //       ),
          //       ListTile(
          //         title: Text("khubaib"),
          //       ),
          //       ListTile(
          //         title: Text("khubaib"),
          //       ),
          //
          //       ListTile(
          //         title: Text("khubaib"),
          //       ),
          //       ListTile(
          //         title: Text("khubaib"),
          //       ),
          //       ListTile(
          //         title: Text("khubaib"),
          //       ),
          //       ListTile(
          //         title: Text("khubaib"),
          //       ),
          //
          //     ],
          //   ),
          // ),
         // TabBarView(
         //     controller: tabController,
         //     children:const [
         //       BirthDayScreen(),
         //       FlightScreen(),
         //       HolidayScreen(),
         //     ]
         // ),


          Expanded(
            child: GridView(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,

                ),
              children: List.generate(icon.length, (index){
                return Column(

                  children: [

                    Icon(icon[index],size: 40,),
                    Text(title[index],style: const TextStyle(fontSize: 20),),
                  ],
                );

              })

            ),
          )



         ],
      ),
      // bottomNavigationBar:  SafeArea(
      //   child: TabBar(
      //     controller: tabController,
      //     unselectedLabelColor: Colors.green,
      //     labelColor: Colors.red,
      //     tabs: const [
      //       Tab(
      //         icon: Icon(Icons.cake),
      //         text: "Birthday",
      //       ),
      //       Tab(
      //         icon: Icon(Icons.flight),
      //         text: "FLight",
      //       ),
      //       Tab(
      //         icon: Icon(Icons.holiday_village),
      //         text: "Holiday",
      //       )
      //     ],
      //   ),
      // ),

      drawer: Drawer(
        child: ListView(
          children:  [
            DrawerHeader(
              child: Image.asset("image/download.png",fit: BoxFit.fill,),
            ),
            const ListTile(
              title: Text("Home",style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.home,size: 40,),
            ),
            const Divider(thickness: 5,),
            const ListTile(
              title: Text("Setting",style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.settings,size: 40,),
            ),
            const Divider(thickness: 5,),
            const ListTile(
              title: Text("Contact",style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.contact_mail,size: 40,),
            ),
            const Divider(thickness: 5,color: Color(0xff789076),height:6,),
            const ListTile(
              title: Text("Logout",style: TextStyle(fontSize: 20),),
              leading: Icon(Icons.logout,size: 40,),
            )
          ],

        ),
      ),

    );
  }
}
