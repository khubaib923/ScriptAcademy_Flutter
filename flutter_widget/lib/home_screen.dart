

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   bool _isMonday=false;
   bool _isTuesday=false;
   int _groupValue=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appbar"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined)),



        ],

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label:const  Text("Add"),
        icon: const Icon(Icons.message),
        onPressed: (){},

        mouseCursor: MouseCursor.defer,

      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.card_giftcard)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.vibration)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.visibility)),

          ],
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RichText(

                text:const TextSpan(
                    children: [
                      TextSpan(text: "Uzair",style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,decorationColor: Colors.green)),
                      TextSpan(text: "Irfan",style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,decorationColor: Colors.green))
                    ],
                   // text: "Khubaib",style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,decorationColor: Colors.green)

                ),
            ),
            TextButton(onPressed: (){}, child: const Text("Icon")),
            IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
            ElevatedButton.icon(onPressed: (){}, icon: const Icon(Icons.text_decrease),label: const Text("Text"),style:ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),

                )
              )
            ),),
            MaterialButton(onPressed: (){},child: const Icon(Icons.menu)),
            CupertinoButton(child: const Text("Click me"), onPressed: (){}),
            OutlinedButton(onPressed: (){}, child:const Text("Icon")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                enableSuggestions: true,
               autocorrect: false,
                decoration: InputDecoration(
                  hintText: "username",
                  labelText: "username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  counterText: "",
                ),
                maxLength: 8,
                //maxLines: 3,
                style: const TextStyle(
                  color: Colors.red
                ),
              ),
            ),
            const Image(image: AssetImage("image/download.png"),height: 50,fit: BoxFit.cover,),
            const SizedBox(height: 10,),
            const Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuWyuFtzhguWjtW4JfoRhcVvvqUGsWRqZkXw&usqp=CAU"),height: 80,fit: BoxFit.cover,),
            const SizedBox(height: 20,),
           const Text("Select Days",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            ListTile(
              leading: Checkbox(
                value:_isMonday ,
                onChanged: (value){
               setState((){
                 _isMonday=value!;
               });
                },

              ),
              title: const Text("Monday",style: TextStyle(fontSize: 20),),
            ),
            ListTile(
              leading: Checkbox(
                value:_isTuesday ,
                onChanged: (values){
                  setState((){
                    _isTuesday=values!;
                  });
                },

              ),
              title: const Text("Tuesday",style: TextStyle(fontSize: 20),),
            ),
          const Text("Select your Role",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
           ListTile(
             title: const Text("Student",style: TextStyle(color:Colors.red,fontSize: 20,fontWeight: FontWeight.bold ),),
             leading: Radio(
                 value: 1,
                 groupValue: _groupValue,
                 onChanged:(int? value){
                   setState((){
                     _groupValue=value!;
                   });
                 }
             ),
           ),
            ListTile(
              title: const Text("Doctor",style: TextStyle(color:Colors.red,fontSize: 20,fontWeight: FontWeight.bold ),),
              leading: Radio(
                  value: 2,
                  groupValue: _groupValue,
                  onChanged:(int? value){
                    setState((){
                      _groupValue=value!;
                    });
                  }
              ),
            ),
            ListTile(
              title: const Text("Teacher",style: TextStyle(color:Colors.red,fontSize: 20,fontWeight: FontWeight.bold ),),
              leading: Radio(
                  value: 3,
                  groupValue: _groupValue,
                  onChanged:(int? value){
                    setState((){
                      _groupValue=value!;
                    });

                  }
              ),
            ),
            const SizedBox(height: 10,),
             const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              backgroundImage: AssetImage("image/download.png",),
              child: Image(
                //image:  AssetImage("image/download.png"),
                image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuWyuFtzhguWjtW4JfoRhcVvvqUGsWRqZkXw&usqp=CAU"),
              ),
            )

          ],
        ),
      ),
    );

  }
}
